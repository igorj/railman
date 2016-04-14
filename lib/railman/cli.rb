require 'thor'
require 'railman'

module Railman
  class CLI < Thor
    include Thor::Actions

    desc "do_something NAME", "TODO task description"
    def do_something(name)
      puts "TODO do something with: #{name}"
    end
  end
end
