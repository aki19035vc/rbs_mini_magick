# frozen_string_literal: true

# rbs_inline: enabled

require "bundler"
require "open3"
require "optparse"
require "pathname"
require "rbs"
require "stringio"

require "mini_magick"

require_relative "rbs_mini_magick/version"
require_relative "rbs_mini_magick/image_magick"
require_relative "rbs_mini_magick/flows"
require_relative "rbs_mini_magick/builder"
require_relative "rbs_mini_magick/generator"
require_relative "rbs_mini_magick/cli"

module RbsMiniMagick
  class Error < StandardError; end
end
