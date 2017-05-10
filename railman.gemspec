$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'railman/version'

Gem::Specification.new do |spec|
  spec.name          = "railman"
  spec.version       = Railman::VERSION
  spec.authors       = ["Igor Jancev"]
  spec.email         = ["igor@masterybits.com"]
  spec.summary       = %q{Rails application generator}
  spec.description   = %q{Rails application generator that speeds up develoment of new rails applications}
  spec.homepage      = "https://github.com/igorj/railman"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency "gem-release", "~> 0.7"
  spec.add_development_dependency "coveralls"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "creategem", "~> 0.7.4"
end
