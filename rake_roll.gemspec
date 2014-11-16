# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rake_roll"
  spec.version       = "0.1.0"
  spec.authors       = ["Stuart Hanscombe"]
  spec.email         = ["hanscs1969@yahoo.co.uk"]
  spec.summary       = "RakeRoll: Git version tagger and changelog creator"
  spec.description   = "RakeRoll: Will version and tag a release and create an updated changelog of the git commits, parsing only commits that are written in a simple markup structure"
  spec.homepage      = "http://www.thelazycamel.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
