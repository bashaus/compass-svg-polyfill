# Compass SVG polyfill

Version 1.0.1

A compass plugin which serves SVG background images to new browsers and 
provides a PNG fallback to old browsers.

## Project details

### Use case

SVGs are great as they're a vector format but some browsers don't support them. 
This script automates the conversion of SVGs to PNGs and provides the CSS for you.

### Problem domain

* broken-links.com -- [Using SVG in backgrounds with PNG fallback](http://www.broken-links.com/2010/06/14/using-svg-in-backgrounds-with-png-fallback/)

## Installation

### Mac OS X (with homebrew)

If you don't already have it, download and install `XQuartz`

    https://xquartz.macosforge.org/landing/

Install `librsvg`

    brew install librsvg

Install `gem`

    gem install compass-svg-polyfill

## Usage

### Load times

The SVG vector images are base64 encoded and included in the CSS output through 
a data URI. The fallback PNG images are linked through a URL. This means that 
on older browsers the load time is slightly slower (because you have to 
download two files) but on more modern browsers you have limited the number 
of HTTP requests.

### Instructions

The following instructions are for adding the SVG background image code to an existing project. 

Add the following to the top of your `config.rb`:

    require "compass-svg-polyfill"

Run compass

    compass watch

Edit your stylesheets and add a reference to the mixin:

    # At the top of your file
    @import "svg-polyfill/svg";

    # Target a specific element
    .element {
        @include background-svg(
            $width: 856,
            $height: 433,
            $svg: "world-map.svg",          /* must exist */
            $png: "world-map-856x433.png"   /* will be generated for you */
        );
    }

When using `compass watch` images are regenerated every time you update your 
CSS files. If you make changes to your SVG images, resave a stylesheet 
containing the image and the PNG images will be regenerated.

## Licence

Copyright (C) 2013, [Bashkim Isai](http://www.bashkim.com.au)

This script is distributed under the MIT licence.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contributors

* @bashaus -- [Bashkim Isai](http://www.bashkim.com.au/)

If you fork this project and create a pull request add your GitHub username, your full name and website to the end of list above.
