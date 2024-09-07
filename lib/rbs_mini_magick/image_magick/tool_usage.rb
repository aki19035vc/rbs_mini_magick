# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module ImageMagick
    class ToolUsage
      class << self
        # @rbs (String, String) -> ImageMagick::ToolUsage
        def build_by_raw_usage(name, raw_usage)
          new(
            name: name,
            options: raw_usage.split("\n").filter_map { build_option_by_raw_line(_1) }
          )
        end

        private

        # @rbs (String) -> Option?
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

      attr_reader :name #: String
      attr_reader :options #: Array[Option]

      # @rbs (name: String, options: Array[Option]) -> void
      def initialize(name:, options:)
        @name = name
        @options = options
      end
    end
  end
end
