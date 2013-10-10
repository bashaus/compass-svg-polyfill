# Compass SVG polyfill

Version 1.0.5

A compass plugin which serves SVG background images to new browsers and 
provides a PNG fallback to old browsers.

## Project details

### Use case

SVGs are great as they're a vector format but some browsers don't support them. 
This script automates the conversion of SVGs to PNGs and provides the CSS for you.

### Problem domain

* broken-links.com -- [Using SVG in backgrounds with PNG fallback](http://www.broken-links.com/2010/06/14/using-svg-in-backgrounds-with-png-fallback/)

## Requirements

In order to use this gem you must have either `ImageMagick` or `librsvg`.

ImageMagick is the recommended library.

## Mac OS X Installation

### ImageMagick

Install `ImageMagick`

    brew install imagemagick

### librsvg

Download and install `XQuartz`

    https://xquartz.macosforge.org/landing/

Install `librsvg`

    brew install librsvg

## Linux Installation

Tested on `Ubuntu 12.04`

### librsvg

Install `librsvg`

    apt-get update
    apt-get install librsvg2-bin

## Usage

### Instructions

The following instructions are for adding the SVG background image code to an existing project. 

Install `gem`

    gem install compass-svg-polyfill

Add the following to the top of your `config.rb`:

    require "compass-svg-polyfill"

Run `compass`

    compass watch

Add your stylesheet:

    # At the top of your file
    @import "compass-svg-polyfill/svg";

    # Optionally, define the default image converter
    $default-image-converter: imagemagick;

    # Target a specific element
    .element {
        @include background-svg(
            $width: 856px,                  /* value must be in pixels */
            $height: 433px,                 /* value must be in pixels */
            $svg: "world-map.svg",          /* file must exist */
            $png: "world-map-856x433.png",  /* file to be generated */
            $inline: false,                 /* optional: include svg in css */
            $image-converter: librsvg       /* optional: imagemagick or librsvg */
        );
    }

When using `compass watch` images are regenerated every time you update your 
CSS files. If you make changes to your SVG images, resave a stylesheet 
containing the image and the PNG images will be regenerated.

### $inline

* Optional
* Default value: false
* Available from: 1.0.4

The SVG vector images can be base64 encoded and included in the CSS output 
through a data URI. The fallback PNG images are linked through a URL. 

This means that on older browsers the load time is slightly slower (because you 
have to download two files) but on more modern browsers you have limited the 
number of HTTP requests.

When `true`: SVG images are encoded in the CSS file and PNG images download via 
a separate HTTP request

When `false`: both SVG and PNG images are downloaded via a separate HTTP request


### $image-converter

* Optional
* Default value: imagemagick
* Valid values: imagemagick, librsvg
* Available from: 1.0.5

You can select which image converter to use on a case-by-case basis using this 
parameter.

## Global variables

### $default-image-converter

* Global
* Optional
* Default value: imagemagick
* Valid values: imagemagick, librsvg
* Available from: 1.0.5

Select which image converter to use globally.

## Licence

Copyright (C) 2013, [Bashkim Isai](http://www.bashkim.com.au)

This script is distributed under the MIT licence.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contributors

* @bashaus -- [Bashkim Isai](http://www.bashkim.com.au/)

If you fork this project and create a pull request add your GitHub username, your full name and website to the end of list above.
