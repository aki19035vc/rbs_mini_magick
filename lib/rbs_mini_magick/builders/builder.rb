# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::Builder
    class Builder
      # @param mini_magick_version [Gem::Version]
      # @return [void]
      def initialize(mini_magick_version:)
        @mini_magick_version = mini_magick_version
      end

      # @return [String]
      def run
        rbs = case mini_magick_version
              when Range.new(Gem::Version.new("5.0"), nil)
                v5_0
              else
                raise Error, "#{mini_magick_version} does not support"
              end

        format_rbs(rbs)
      end

      private

      # @!attribute [r] mini_magick_version
      # @return [Gem::Version]
      attr_reader :mini_magick_version

      # @return [Hash<String, Array<RbsMiniMagick::ImageMagick::CommandLineOption>>]
      def options_by_tool
        @options_by_tool ||= ImageMagick::TOOL_NAMES.to_h do |tool|
          tool.then { ImageMagick::UsageFetcher.new(tool_name: _1).run }
              .then { ImageMagick::UsageParser.new(raw_usage: _1).run }
              .then { [tool, _1] }
        end
      end

      # @return [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      def mogrify_options
        @mogrify_options ||= options_by_tool.fetch("mogrify")
      end

      # @param rbs [String]
      # @return [String]
      def format_rbs(rbs)
        out = StringIO.new
        decls = RBS::Parser.parse_signature(rbs).then { _1[1] + _1[2] }

        RBS::Writer.new(out: out).write(decls)

        out.string
      end
    end
  end
end
