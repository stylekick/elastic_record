# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elastic_record/version'

Gem::Specification.new do |spec|
  spec.name          = "elastic_record"
  spec.version       = ElasticRecord::VERSION
  spec.authors       = ["Anand"]
  spec.email         = ["anand180@gmail.com"]
  spec.summary       = %q{ActiveModel API for ElasticSearch}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "flex-rails", "~> 1.0"
  spec.add_dependency "patron", "~> 0.4"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "tire"
  spec.add_development_dependency "rspec"
end
