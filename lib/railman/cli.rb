require 'thor'
require 'yaml'
require 'creategem'
require 'railman/config'
require 'railman/secret'
require 'railman/version'

module Railman
  class CLI < Thor
    include Thor::Actions
    include Creategem::Git

    attr_accessor :app_name

    # this is where the thor generator templates are found
    def self.source_root
      File.expand_path('../../../templates', __FILE__)
    end

    desc "new APPNAME [--public] [--bitbucket]", "Create new rails application named APPNAME"
    option :public, type: :boolean, default: false, desc: "When true, the remote git repository is made public, otherwise the repository is private (default)"
    option :bitbucket, type: :boolean, default: false, desc: "When true, Bitbucket repository is created, otherwise Github (default)"
    def new(app_name)
      say "Create a new rails application named: #{app_name}", :green
      config = create_config(app_name)
      apply_rails_template(config)
      say "The rails application '#{app_name}' was successfully created.", :green
      say "Please check the settings in .env and run 'rake db:create' to create the local databases.", :blue
    end

    desc "upgrade APPNAME", "Upgrade the rails upplication named APPNAME"
    def upgrade(app_name)
      puts "Upgrade the rails application: #{app_name}"
      config = load_config(app_name)
      apply_rails_template(config, false)
      say "The rails application '#{app_name}' was successfully upgraded.", :green
    end

    private

    def create_config(app_name)
      config = Railman::Config.new
      config.app_name = app_name
      config.class_name = Thor::Util.camel_case(app_name)
      config.admin_email = ask("What is the administrator email address?")
      config.domain = ask("What is the url of the application (without http and www)?")
      if yes?("Do you want me to configure www.#{config.domain} domain to be redirected to #{config.domain}? (y/n)")
        config.www_domain = "www.#{config.domain}"
        config.domains = [config.domain, config.www_domain]
      else
        config.www_domain = nil
        config.domains = [config.domain]
      end
      config.server = ask("What is the name of the production server?")
      config.private = !options[:public]
      config.vendor = options[:bitbucket] ? :bitbucket : :github
      config
    end

    def load_config(app_name)
      if File.exists? File.join(app_name, ".railman")
        YAML::load_file File.join(app_name, ".railman")
      else
        create_config(app_name)
      end
    end

    def save_config(config)
      config.version = Railman::VERSION
      File.open File.join(config.app_name, ".railman"), "w" do |file|
        file.write config.to_yaml
      end
    end

    def apply_rails_template(config, create = true)
      @config = config
      @repository = Creategem::Repository.new(vendor: config.vendor.to_sym,
                                              user: git_repository_user_name(config.vendor.to_sym),
                                              name: config.app_name,
                                              gem_server_url: gem_server_url(config.vendor.to_sym),
                                              private: config.private)
      @rake_secret = "TODO: generate with: rake secret"
      @unicorn_behind_nginx = true
      if create
        directory "rails_app", @config.app_name
        @rake_secret = Railman::Secret.generate_secret
        @unicorn_behind_nginx = false
        template "rails_app/.env.example.development.tt", "#{@config.app_name}/.env"
        @rake_secret = Railman::Secret.generate_secret
        remove_file "#{@config.app_name}/.env.example.test"
        template "rails_app/.env.example.test.tt", "#{@config.app_name}/.env.example.test"
      else
        directory "rails_app", @config.app_name, exclude_pattern: /home_controller|index\.html\.erb/
        # delete files that shouldn't exist in the new version
        remove_file "#{@config.app_name}/config/unicorn.rb"
        remove_file "#{@config.app_name}/bin/unicorn"
        remove_file "#{@config.app_name}/bin/unicorn_rails"
        remove_file "#{@config.app_name}/app/jobs/.keep"
        remove_file "#{@config.app_name}/app/models/.keep"
        remove_dir "#{@config.app_name}/vendor/assets"
      end
      save_config(@config)
      Dir.chdir @config.app_name do
        run "bundle update"
        run "chmod +x bin/*"
        if create
          create_local_git_repository
          create_remote_git_repository(@repository) if yes?("Do you want me to create #{config.vendor} repository named #{@config.app_name}? (y/n)")
        end
      end
    end
  end
end
