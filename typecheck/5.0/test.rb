# frozen_string_literal: true

require "mini_magick"

image = MiniMagick::Image.open("input.jpg")
image.resize "100x100"
