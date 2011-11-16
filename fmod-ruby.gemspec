# -*- encoding: utf-8 -*-
require File.expand_path('../lib/fmod/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ronen barzel"]
  gem.email         = ["ronen@barzel.org"]
  gem.description   = %q{Wrapper for the FMOD audio library}
  gem.summary       = %q{Wrapper for the FMOD audio library}
  gem.homepage      = "git://github.com/ronen/fmod-ruby.git"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "fmod-ruby"
  gem.require_paths = ["lib"]
  gem.version       = Fmod::VERSION

  gem.add_dependency("ffi")
end
