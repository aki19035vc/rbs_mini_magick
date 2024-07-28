# frozen_string_literal: true

module RbsMiniMagick
  module ImageMagick
    # RbsMiniMagick::ImageMagick::UsageParser
    class UsageParser
      # @param raw_usage [String]
      # @return [void]
      def initialize(raw_usage:)
        @raw_usage = raw_usage
      end

      # @return [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      def run
        parse_raw_command_line_options
          .map { build_command_line_option(_1) }
      end

      private

      # @!attribute [r] raw_usage
      # @return [String]
      attr_reader :raw_usage

      # @return [Array<String>]
      def parse_raw_command_line_options
        raw_usage.split("\n").filter_map do |line|
          line.match(/^\s*(-\S+(?: \S+)*)\s*/)&.then { _1[1] }
        end
      end

      # @param raw_string [String]
      # @return [RbsMiniMagick::ImageMagick::CommandLineOption]
      def build_command_line_option(raw_string)
        splited = raw_string.split

        CommandLineOption.new(
          name: String(splited.first),
          args: splited[1..] || []
        )
      end
    end
  end
end
