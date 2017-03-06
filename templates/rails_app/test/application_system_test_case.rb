require "test_helper"
require "capybara/poltergeist"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :poltergeist
  #driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  fixtures :all
end
