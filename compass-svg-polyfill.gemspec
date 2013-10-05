require File.join([File.dirname(__FILE__),'lib','compass-svg-polyfill','version.rb'])

Gem::Specification.new do |s|
  s.name        = "compass-svg-polyfill"
  s.version     = Compass::SVGPolyfill::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bashkim Isai"]
  s.license     = "MIT"
  s.homepage    = "http://github.com/bashaus/compass-svg-polyfill"
  s.summary     = "Converts SVG images to PNG for use in older browsers"

  s.files         = Dir["lib/**/*", "README*"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency("sass", [">= 3.1.0"])
  s.add_runtime_dependency("compass", [">= 0.11.1"])
end