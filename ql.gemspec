# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'q/version'

Gem::Specification.new do |spec|
  spec.name          = "ql"
  spec.version       = Q::VERSION
  spec.authors       = ["Stojan Dimitrovski"]
  spec.email         = ["s.dimitrovski@gmail.com"]
  spec.summary       = %q{Q, a simple programming language.}
  spec.description   = %q{Q is a simple programming language implemented on top of Ruby with Treetop.}
  spec.homepage      = "https://github.com/hf/q"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"

  spec.add_dependency "treetop", "~> 1.4"
end
