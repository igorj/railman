require 'thor'
require 'railman'

module Railman
  class CLI < Thor
    include Thor::Actions

    desc "new APPNAME", "Create new rails application named APPNAME"
    def new(name)
      puts "TODO create new rails application: #{name}"
    end

    desc "update APPNAME", "Update the rails upplication named APPNAME"
    def update(name)
      puts "TODO update the rails application: #{name}"
    end
  end
end
