# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arcgis_server/version'

Gem::Specification.new do |spec|
  spec.name          = "arcgis_server"
  spec.version       = ArcgisServer::VERSION
  spec.authors       = ["Stefan Novak"]
  spec.email         = ["stefan.louis.novak@gmail.com"]
  spec.description   = %q{An object-oriented wrapper for the ArcGIS Server API}
  spec.summary       = %q{An object-oriented wrapper for the ArcGIS Server API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
