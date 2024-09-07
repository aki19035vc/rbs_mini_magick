# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module ImageMagick
    class UsageFetcher
      # @rbs (tool_name: String) -> void
      def initialize(tool_name:)
        @tool_name = tool_name
      end

      # @rbs () -> String
      def run
        tool = MiniMagick::Tool.new(tool_name)
        tool.help # steep:ignore
        tool.call(errors: false, warnings: false)
      end

      private

      attr_reader :tool_name #: String
    end
  end
end
