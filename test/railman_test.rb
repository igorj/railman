require 'test_helper'

class RailmanTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Railman::VERSION
  end
end
