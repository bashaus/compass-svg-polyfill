require 'compass-svg-polyfill/sass_functions.rb'

Compass::Frameworks.register(
	'compass-svg-polyfill',
	:stylesheets_directory => File.join(File.dirname(__FILE__), 'compass-svg-polyfill', 'stylesheets')
)