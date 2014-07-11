# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/knife/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-partial-search"
  spec.version       = Knife::PartialSearch::VERSION
  spec.authors       = ["Gregoire Seux"]
  spec.email         = ["g.seux@criteo.com"]
  spec.summary       = "Improve usual knife commands thanks to partial-search"
  spec.homepage      = "https://gitlab.criteois.lan/ruby-gems/knife-partial-search"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "chef", ">= 11"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
