# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_ai/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_ai"
  spec.version       = RubyAi::VERSION
  spec.authors       = ["igavriil"]
  spec.email         = ["iasongavriil@gmail.com"]

  spec.summary       = %q{Artificial Intelligence library for ruby}
  spec.description   = %q{Implementation of algorithms described in 'Artificial Intelligence: A modern approach'}
  spec.homepage      = "http://github.com/igavriil/ruby_ai"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "coveralls"
end
