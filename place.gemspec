lib = File.join(File.dirname(__FILE__), "lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'place/version'

Gem::Specification.new do |spec|
  spec.name = "place-api"
  spec.version = Place::VERSION
  spec.required_ruby_version = ">= 2.0.0"
  spec.summary = "Place ruby library"
  spec.description = "A simple library to interface with the Place REST API. See https://developer.placepay.com for details."
  spec.author = "Place"
  spec.email = "help@placepay.com"
  spec.homepage = "https://developer.placepay.com"
  spec.license = "MIT"

  spec.files = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
