require 'simplecov' if ENV['COVERAGE'] == 'true'

# default rails test configuration
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# use minitest-reporters to create xmls for jenkins and nicer terminal reporting
require 'minitest/reporters'
require 'minitest/reporters/screenshot_reporter'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new,
                          Minitest::Reporters::JUnitReporter.new,
                          Minitest::Reporters::ScreenshotReporter.new]

# configure webtests with capybara and poltergeist (headless)
require 'capybara/rails'
require 'capybara_minitest_spec'
require 'capybara/poltergeist'

CAPYBARA_WINDOW_SIZE = [1024, 768]

if ENV['HEADLESS'] == 'true'
  # headless driver configuration
  Capybara.register_driver :poltergeist do |app|
    poltergeist_options = { debug: false, timeout: 30, js_errors: true, window_size: CAPYBARA_WINDOW_SIZE }
    Capybara::Poltergeist::Driver.new(app, poltergeist_options)
  end
  Capybara.default_driver = :poltergeist
else
  # chrome browser driver configuration
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  Capybara.default_driver = :selenium
  Capybara.current_session.driver.browser.manage.window.resize_to CAPYBARA_WINDOW_SIZE[0], CAPYBARA_WINDOW_SIZE[1]
end
Capybara.default_max_wait_time = 5   # how long should capybara wait for elements to appear on the page (ajax)

# use database_cleaner to clean the database after every test with truncation, instead of using transactional fixtures
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

# default test class for webtests
class WebTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  extend Minitest::Spec::DSL
  include Minitest::Reporters::Screenshot

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # disable transactional fixtures, as we use DatabaseCleaner
  self.use_transactional_fixtures = false

  # clean database after each test with database_cleaner
  def after_teardown
    super
    DatabaseCleaner.clean
  end
end
