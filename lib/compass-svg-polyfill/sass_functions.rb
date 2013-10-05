module Sass::Script::Functions
  def svg_polyfill(width, height, svgIn, pngOut)
    assert_type width, :Number
    assert_type height, :Number
    assert_type svgIn, :String
    assert_type pngOut, :String

    svgPath = File.join Compass.configuration.images_path, svgIn.value
    pngPath = File.join Compass.configuration.images_path, pngOut.value

    begin
      if !File.exists? svgPath
        Compass::Logger.new.record :error, File.join(Compass.configuration.images_dir, svgIn.value)
        raise "SVG does not exist"
      end

      if File.exists? File.join(Compass.configuration.images_path, pngOut.value)
        Compass::Logger.new.record :overwrite, File.join(Compass.configuration.images_dir, pngOut.value)
      else
        Compass::Logger.new.record :create, File.join(Compass.configuration.images_dir, pngOut.value)
      end

      system(
        "rsvg-convert",         # Process
        "-w", width.to_s,       # Width
        "-h", height.to_s,      # Height
        "#{svgPath}",           # Input
        "-o", "#{pngPath}"      # Output
      )

      Sass::Script::Number.new 1
    rescue
      Sass::Script::Number.new 0
    end
  end
  declare :svg_polyfill, :args => [:Number, :Number, :String, :String]
end