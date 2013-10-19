require File.join([File.dirname(__FILE__),'lib','compass-svg-polyfill','version.rb'])

Gem::Specification.new do |s|
  s.name        = "compass-svg-polyfill"
  s.version     = Compass::SVGPolyfill::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bashkim Isai"]
  s.license     = "MIT"
  s.homepage    = "http://github.com/bashaus/compass-svg-polyfill"
  s.summary     = "Converts SVG images to PNG for use in older browsers"
  s.description = <<-EOF
    SVG images are a great way to display vector images online; however some 
    older web browsers do not support this format.

    The compass-svg-polyfill gem generates fallback PNG images for these 
    browsers.
  EOF

  s.files         = Dir["lib/**/*", "README*"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rmagick"
  s.add_runtime_dependency "sass"
  s.add_runtime_dependency "compass"
end