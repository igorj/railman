require 'thor'
require 'creategem'
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
      apply_rails_template(app_name)
      say "The rails application '#{app_name}' was successfully created.", :green
      say "Please check the settings in .env", :blue
    end

    desc "upgrade APPNAME", "Upgrade the rails upplication named APPNAME"
    def upgrade(app_name)
      puts "TODO upgrade the rails application: #{app_name}"
      apply_rails_template(app_name, false)
      say "The rails application '#{app_name}' was successfully upgraded.", :green
      say "Please check the settings in .env", :blue
    end

    private

    def apply_rails_template(app_name, create = true)
      @app_name = app_name
      @class_name = Thor::Util.camel_case(app_name)
      @admin_email = ask("What is the adminitrator email address?")
      @domain = ask("What is the url of the application (without http and www)?")
      if yes?("Do you want me to configure www.#{@domain} domain to be redirected to #{@domain}? (y/n)")
        @www_domain = "www.#{@domain}"
        @domains = [@domain, @www_domain]
      else
        @www_domain = nil
        @domains = [@domain]
      end
      @server = ask("What is the name of the production server?")
      @repository = Creategem::Repository.new(vendor: :bitbucket,
                                              user: git_repository_user_name(:bitbucket),
                                              name: app_name,
                                              gem_server_url: gem_server_url(:bitbucket))
      @rake_secret = "TODO: generate with: rake secret"
      @unicorn_behind_nginx = true
      directory "rails_app", app_name
      @rake_secret = Railman::Secret.generate_secret
      @unicorn_behind_nginx = false
      template "rails_app/.env.example.development.tt", "#{app_name}/.env"
      Dir.chdir app_name do
        run "bundle install"
        run "chmod +x bin/*"
        if create
          create_local_git_repository
          create_remote_git_repository(@repository) if yes?("Do you want me to create bitbucket repository named #{app_name}? (y/n)")
        end
      end
    end
  end
end
