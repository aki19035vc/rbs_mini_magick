# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::ImageMagick
  module ImageMagick
    # @return [String<String>]
    TOOL_NAMES = %w[
      animate
      compare
      composite
      conjure
      convert
      display
      identify
      import
      mogrify
      montage
      stream
    ].freeze
    public_constant :TOOL_NAMES
  end
end

require_relative "image_magick/command_line_option"
require_relative "image_magick/usage_fetcher"
require_relative "image_magick/usage_parser"
