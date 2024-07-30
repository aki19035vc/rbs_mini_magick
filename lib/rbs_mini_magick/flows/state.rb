# frozen_string_literal: true

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::State
    class State
      class << self
        # @param tool_usages [Array<RbsMiniMagick::ImageMagick::ToolUsage>]
        # @return [RbsMiniMagick::Flows::State]
        def init(tool_usages:)
          new(tool_usages: tool_usages, rbs: "")
        end
      end

      # @!attribute [r] tool_usages
      # @return [Array<RbsMiniMagick::ImageMagick::ToolUsage>]
      attr_reader :tool_usages

      # @param tool_usages [Array<RbsMiniMagick::ImageMagick::ToolUsage>]
      # @param rbs [String]
      # @return [void]
      def initialize(tool_usages:, rbs:)
        @tool_usages = tool_usages
        @tool_usage_by_name = tool_usages.to_h { [_1.name, _1] }
        @rbs = rbs
      end

      # @param tool_name [String]
      # @return [RbsMiniMagick::ImageMagick::ToolUsage]
      def fetch_tool_usage(tool_name)
        tool_usage_by_name.fetch(tool_name)
      end

      # @param new_rbs [String]
      # @return [RbsMiniMagick::Flows::State]
      def concat_rbs(new_rbs)
        self.class.new(
          tool_usages: tool_usages,
          rbs: [rbs, new_rbs].join("\n")
        )
      end

      # @return [String]
      def formated_rbs
        @formated_rbs ||= format_rbs
      end

      private

      # @!attribute [r] rbs
      # @return [String]
      attr_reader :rbs
      # @!attribute [r] tool_usage_by_name
      # @return [Hash<String, RbsMiniMagick::ImageMagick::ToolUsage>]
      attr_reader :tool_usage_by_name

      # @return [String]
      def format_rbs
        out = StringIO.new
        decls = RBS::Parser.parse_signature(rbs).then { _1[1] + _1[2] }

        RBS::Writer.new(out: out).write(decls)

        out.string
      end
    end
  end
end
