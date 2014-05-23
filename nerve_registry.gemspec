# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nerve_registry/version'

Gem::Specification.new do |spec|
  spec.name          = "nerve_registry"
  spec.version       = NerveRegistry::VERSION
  spec.authors       = ["Dan Kinsley"]
  spec.email         = ["dan@thinkingphones.com"]
  spec.summary       = %q{A docker sidekick that registers ip/port information into etcd}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "nerve", "~> 0.5.3"
  #spec.add_dependency "nerve"
end
