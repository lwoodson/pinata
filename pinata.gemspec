# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinata/version'

Gem::Specification.new do |gem|
  gem.name          = "pinata"
  gem.version       = Pinata::VERSION
  gem.authors       = ["lwoodson"]
  gem.email         = ["lance@webmaneuvers.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('slop')
  gem.add_dependency('git')
  gem.add_dependency('text-table')
  gem.add_dependency('cane')
  gem.add_development_dependency('rspec-core')
  gem.add_development_dependency('rspec-expectations')
  gem.add_development_dependency('rspec-mocks')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('pry-debugger')
end
