require 'tempfile'
require 'fileutils'
require 'digest'
require 'rmagick' unless Object.const_defined?("Magick")

module Sass::Script::Functions
  def svg_polyfill(width, height, svgName, pngName, imageConverter)
    assert_type width, :Number
    assert_type height, :Number
    assert_type svgName, :String
    assert_type pngName, :String
    assert_type imageConverter, :String

    # Normalise values
    svgFilepath = File.join Compass.configuration.images_path, svgName.value.to_s
    pngFilepath = File.join Compass.configuration.images_path, pngName.value.to_s
    imageConverter = imageConverter.value.to_sym

    # Helper objects
    logger = Compass::Logger.new
    cache_store = environment.options[:cache_store]

    # Check if file exists
    if !File.exists? svgFilepath
      raise Sass::SyntaxError, "SVG file does not exist #{svgName.value.to_s}"
    end

    # Create a temporary output file
    tmpFile = Tempfile.new(['compass-svg-polyfill', '.png'])
    tmpFile.close false

    case imageConverter
    when :imagemagick
      img = Magick::Image.read(svgFilepath).first
      img.resize!(width.value.to_i, height.value.to_i)
      img.write tmpFile.path
    when :librsvg
      system(
        "rsvg-convert",      # Process
        "-w", width.value,   # Width
        "-h", height.value,  # Height
        svgFilepath,         # Input
        "-o", tmpFile.path   # Output
      )
    else
      raise Sass::SyntaxError, "Unknown image converter #{imageConverter}"
    end

    # Setup cache values
    cacheKey = cache_store.key(File.dirname(pngFilepath), File.basename(pngFilepath))
    cacheSHA = Digest::SHA1.hexdigest(pngFilepath)
    cacheVal = "#{width} #{height} #{Digest::SHA1.file(svgFilepath).hexdigest}"

    action = nil

    if File.exists? pngFilepath
      action = :overwrite

      if (cachedSHA = cache_store.retrieve(cacheKey, cacheSHA)) then
        if cachedSHA.eql? cacheVal then
          action = :unchanged
        end
      end
    else
      action = :create
    end

    logger.record action, pngName.value

    case action
    when :overwrite, :create
      # Save the file
      FileUtils.mv(tmpFile.path, pngFilepath)
    end

    # Save the cache key
    cache_store.store(cacheKey, cacheSHA, cacheVal)

    # Remove temp file
    tmpFile.unlink

    Sass::Script::Bool.new true
  end

  declare :svg_polyfill, :args => [:Number, :Number, :String, :String]
end
