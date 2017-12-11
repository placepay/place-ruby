lib = File.join(File.dirname(__FILE__), "lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rentshare/version'

Gem::Specification.new do |spec|
  spec.name = "rentshare"
  spec.version = RentShare::VERSION
  spec.required_ruby_version = ">= 2.0.0"
  spec.summary = "RentShare ruby library"
  spec.description = "A simple library to interface with the RentShare REST API. See https://developer.rentshare.com for details."
  spec.author = "RentShare"
  spec.email = "help@rentshare.com"
  spec.homepage = "https://developer.rentshare.com"
  spec.license = "MIT"

  spec.add_dependency("faraday", "~> 0.10")

  spec.files = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
