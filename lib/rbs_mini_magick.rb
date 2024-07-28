# frozen_string_literal: true

require "bundler"
require "open3"
require "optparse"
require "pathname"
require "rbs"
require "stringio"

require "mini_magick"

# RbsMiniMagick
module RbsMiniMagick
  # RbsMiniMagick::Error
  class Error < StandardError; end
end

require_relative "rbs_mini_magick/version"
require_relative "rbs_mini_magick/image_magick"
require_relative "rbs_mini_magick/builders"
require_relative "rbs_mini_magick/generator"
require_relative "rbs_mini_magick/cli"
