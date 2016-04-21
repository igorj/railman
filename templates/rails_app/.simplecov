require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

SimpleCov.start do
  coverage_dir 'test/coverage'

  load_profile 'rails'

  add_group 'Controllers', 'app/controllers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Libraries', 'lib'

  add_filter 'db'
  add_filter 'test'
  add_filter 'config'
  add_filter 'vendor'
end


