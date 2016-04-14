require 'thor'
require 'railman'

module Railman
  class CLI < Thor
    include Thor::Actions

    attr_accessor :app_name

    # this is where the thor generator templates are found
    def self.source_root
      File.expand_path('../../../templates', __FILE__)
    end

    desc "new APPNAME", "Create new rails application named APPNAME"
    def new(app_name)
      say "Create a new rails application named: #{app_name}", :green
      @app_name = app_name
      @class_name = Thor::Util.camel_case(app_name)
      directory "rails_app", app_name
      Dir.chdir app_name do
      #  create_local_git_repository
        run "bundle install"
      #  create_remote_git_repository(@repository)
      end
      say "The rails application '#{app_name}' was successfully created.", :green
    end

    desc "update APPNAME", "Update the rails upplication named APPNAME"
    def update(app_name)
      puts "TODO update the rails application: #{app_name}"
    end
  end
end
