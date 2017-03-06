require 'simplecov' if ENV['COVERAGE'] == 'true'

# default rails test configuration
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# use minitest-reporters to create xmls for jenkins and nicer terminal reporting
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new,
                          Minitest::Reporters::JUnitReporter.new]

# default test class for unit tests
class UnitTest < ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end
