# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rake_roll"
  spec.version       = "0.1.1"
  spec.authors       = ["Stuart Hanscombe"]
  spec.email         = ["hanscs1969@yahoo.co.uk"]
  spec.summary       = "RakeRoll: Git version tagger and changelog creator"
  spec.description   = "RakeRoll: Roll out your release versions with ease, RakeRoll will version and tag a release then create an updated changelog of the git commits (picking only those starting with a *)"
  spec.homepage      = "http://www.thelazycamel.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "pry", "~> 0"
end
