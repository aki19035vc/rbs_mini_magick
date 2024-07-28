# frozen_string_literal: true

module RbsMiniMagick
  module ImageMagick
    # RbsMiniMagick::ImageMagick::UsageFetcher
    class UsageFetcher
      # @param tool_name [String]
      # @return [void]
      def initialize(tool_name:)
        @tool_name = tool_name
      end

      # @return [String]
      def run
        tool = MiniMagick::Tool.new(tool_name)
        tool.help # steep:ignore
        tool.call(errors: false, warnings: false)
      end

      private

      # @!attribute [r] tool_name
      # @return [String]
      attr_reader :tool_name
    end
  end
end
