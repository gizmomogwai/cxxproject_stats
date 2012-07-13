# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cxxproject_stats/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christian Köstlin"]
  gem.email         = ["christian.koestlin@esrlabs.com"]
  gem.description   = %q{creates some stats for cxx-projects}
  gem.summary       = %q{...}
  gem.homepage      = "http://marcmo.github.com/cxxproject/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cxxproject_stats"
  gem.require_paths = ["lib"]
  gem.version       = CxxprojectStats::VERSION
#  gem.add_dependency 'cxxproject'
end
