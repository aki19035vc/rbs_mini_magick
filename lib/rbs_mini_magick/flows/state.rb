# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module Flows
    class State
      class << self
        # @rbs (tool_usages: Array[ImageMagick::ToolUsage]) -> Flows::State
        def init(tool_usages:)
          new(tool_usages: tool_usages, rbs: "")
        end
      end

      attr_reader :tool_usages #: Array[ImageMagick::ToolUsage]

      # @rbs (tool_usages: Array[ImageMagick::ToolUsage], rbs: String) -> void
      def initialize(tool_usages:, rbs:)
        @tool_usages = tool_usages
        @tool_usage_by_name = tool_usages.to_h { [_1.name, _1] }
        @rbs = rbs
      end

      # @rbs (String) -> ImageMagick::ToolUsage
      def fetch_tool_usage(tool_name)
        tool_usage_by_name.fetch(tool_name)
      end

      # @rbs (String) -> Flows::State
      def concat_rbs(new_rbs)
        self.class.new(
          tool_usages: tool_usages,
          rbs: [rbs, new_rbs].join("\n")
        )
      end

      # @rbs () -> String
      def formated_rbs
        @formated_rbs ||= format_rbs
      end

      private

      attr_reader :rbs #: String
      attr_reader :tool_usage_by_name #: Hash[String, ImageMagick::ToolUsage]

      # @rbs () -> String
      def format_rbs
        out = StringIO.new
        decls = RBS::Parser.parse_signature(rbs).then { _1[1] + _1[2] }

        RBS::Writer.new(out: out).write(decls)

        out.string
      end
    end
  end
end
