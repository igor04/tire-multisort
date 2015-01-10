# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tire-multisort/version'

Gem::Specification.new do |spec|
  spec.name          = "tire-multisort"
  spec.version       = Tire::MultiSort::VERSION
  spec.authors       = ["igor04"]
  spec.email         = ["igor.s04g@gmail.com"]
  spec.summary       = %q{tire sort extension}
  spec.description   = %q{multi_sort extended tire sort with some abilities}
  spec.homepage      = "https://github.com/igor04/tire-multisort"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "tire"
end
