require 'thor'
require 'yaml'
require 'creategem'
require 'railman/config'
require 'railman/secret'

module Railman
  class CLI < Thor
    include Thor::Actions
    include Creategem::Git

    attr_accessor :app_name

    # this is where the thor generator templates are found
    def self.source_root
      File.expand_path('../../../templates', __FILE__)
    end

    desc "new APPNAME", "Create new rails application named APPNAME"
    def new(app_name)
      say "Create a new rails application named: #{app_name}", :green
      config = create_config(app_name)
      apply_rails_template(config)
      say "The rails application '#{app_name}' was successfully created.", :green
      say "Please check the settings in .env", :blue
    end

    desc "upgrade APPNAME", "Upgrade the rails upplication named APPNAME"
    def upgrade(app_name)
      puts "Upgrade the rails application: #{app_name}"
      config = load_config(app_name)
      apply_rails_template(config, false)
      say "The rails application '#{app_name}' was successfully upgraded.", :green
      say "Please check the settings in .env", :blue
    end

    private

    def create_config(app_name)
      config = Railman::Config.new
      config.app_name = app_name
      config.class_name = Thor::Util.camel_case(app_name)
      config.admin_email = ask("What is the adminitrator email address?")
      config.domain = ask("What is the url of the application (without http and www)?")
      if yes?("Do you want me to configure www.#{config.domain} domain to be redirected to #{config.domain}? (y/n)")
        config.www_domain = "www.#{config.domain}"
        config.domains = [config.domain, config.www_domain]
      else
        config.www_domain = nil
        config.domains = [config.domain]
      end
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
      File.open File.join(config.app_name, ".railman"), "w" do |file|
        file.write config.to_yaml
      end
    end

    def apply_rails_template(config, create = true)
      @config = config
      @repository = Creategem::Repository.new(vendor: :bitbucket,
                                              user: git_repository_user_name(:bitbucket),
                                              name: @config.app_name,
                                              gem_server_url: gem_server_url(:bitbucket))
      @rake_secret = "TODO: generate with: rake secret"
      @unicorn_behind_nginx = true
      directory "rails_app", @config.app_name
      if create
        @rake_secret = Railman::Secret.generate_secret
        @unicorn_behind_nginx = false
        template "rails_app/.env.example.development.tt", "#{@config.app_name}/.env"
        save_config(@config)
      end
      Dir.chdir @config.app_name do
        run "bundle install"
        run "chmod +x bin/*"
        if create
          create_local_git_repository
          create_remote_git_repository(@repository) if yes?("Do you want me to create bitbucket repository named #{@config.app_name}? (y/n)")
        end
      end
    end
  end
end
