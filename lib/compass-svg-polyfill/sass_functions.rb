require 'RMagick'

module Sass::Script::Functions
  def svg_polyfill(width, height, svgName, pngName, imageConverter)
    assert_type width, :Number
    assert_type height, :Number
    assert_type svgName, :String
    assert_type pngName, :String
    assert_type imageConverter, :String

    imageConverter = imageConverter.value.to_sym

    logger = Compass::Logger.new

    svgName = svgName.value.to_s
    svgPath = File.join Compass.configuration.images_path, svgName

    pngName = pngName.value.to_s
    pngPath = File.join Compass.configuration.images_path, pngName

    if !File.exists? svgPath
      raise Sass::SyntaxError, "svg does not exist #{svgName}"
    end

    if File.exists? pngPath
      logger.record :overwrite, pngName
    else
      logger.record :create, pngName
    end

    case imageConverter
    when :imagemagick
      img = Magick::Image.read(svgPath).first
      img.resize!(width.value.to_i, height.value.to_i)
      img.write pngPath
    when :librsvg
      system(
        "rsvg-convert",           # Process
        "-w", "#{width.value}",   # Width
        "-h", "#{height.value}",  # Height
        "#{svgPath}",             # Input
        "-o", "#{pngPath}"        # Output
      )
    else
      raise Sass::SyntaxError, "Unknown image converter #{imageConverter}"
    end

    Sass::Script::Bool.new true
  end

  declare :svg_polyfill, :args => [:Number, :Number, :String, :String]
end