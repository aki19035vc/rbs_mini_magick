# frozen_string_literal: true

require "mini_magick"

image = MiniMagick::Image.open("input.jpg")
image.resize "100x100"
image.auto_orient.strip

image.combine_options do |c|
  c.resize "100x100"
  c.auto_orient.strip
end
