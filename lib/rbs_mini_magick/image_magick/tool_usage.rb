# frozen_string_literal: true

module RbsMiniMagick
  module ImageMagick
    # RbsMiniMagick::ImageMagick::ToolUsage
    class ToolUsage
      class << self
        # @param name [String]
        # @param raw_usage [String]
        # @return [RbsMiniMagick::ImageMagick::ToolUsage]
        def build_by_raw_usage(name, raw_usage)
          new(
            name: name,
            options: raw_usage.split("\n").filter_map { build_option_by_raw_line(_1) }
          )
        end

        private

        # @param raw_line [String]
        # @return [RbsMiniMagick::ImageMagick::Option, nil]
        def build_option_by_raw_line(raw_line)
          splited = raw_line.match(/^\s*(-\S+(?: \S+)*)\s*/)
                            &.then { _1[1] }
                            &.split

          return if splited.nil?

          Option.new(
            name: String(splited.first),
            args: splited[1..] || []
          )
        end
      end

      # @!attribute [r] name
      # @return [String]
      attr_reader :name
      # @!attribute [r] options
      # @return [Array<RbsMiniMagick::ImageMagick::Option>]
      attr_reader :options

      # @param name [String]
      # @param options [Array<RbsMiniMagick::ImageMagick::Option>]
      # @return [void]
      def initialize(name:, options:)
        @name = name
        @options = options
      end
    end
  end
end
