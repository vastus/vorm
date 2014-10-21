# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vorm/version'

Gem::Specification.new do |spec|
  spec.name          = "vorm"
  spec.version       = Vorm::VERSION
  spec.authors       = ["Juho Hautala"]
  spec.email         = ["juho.hautala@helsinki.fi"]
  spec.summary       = %q{Simple ORM.}
  spec.description   = %q{Simple, pluggable (your own db adapter) ORM for those little projects.}
  spec.homepage      = "https://github.com/vastus/vorm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3.2"
  spec.add_development_dependency "rspec", "~> 3.1"
end

