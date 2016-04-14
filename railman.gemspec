$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'railman/version'

Gem::Specification.new do |spec|
  spec.name          = "railman"
  spec.version       = Railman::VERSION
  spec.authors       = ["Igor Jancev"]
  spec.email         = ["igor@masterybits.com"]
  spec.summary       = %q{TODO Summary what the gem is for}
  spec.description   = %q{TODO Longer description of the gem}
  spec.homepage      = "https://github.com/igorj/railman"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
  spec.add_development_dependency "gem-release", "~> 0.7"
  spec.add_development_dependency "geminabox", "~> 0.13"
  spec.add_dependency "thor", "~> 0.19"

end
