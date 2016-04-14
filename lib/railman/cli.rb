require 'thor'
require 'railman'

module Railman
  class CLI < Thor
    include Thor::Actions

    desc "new APPNAME", "Create new rails application named APPNAME"
    def new(name)
      puts "TODO create new rails application: #{name}"
    end
  end
end
