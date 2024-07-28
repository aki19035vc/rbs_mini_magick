# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::ToolInterface
    class ToolInterface
      # @param tool_name [String]
      # @param options [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      # @return [void]
      def initialize(tool_name:, options:)
        @tool_name = tool_name
        @options = options
      end

      private

      # @!attribute [r] tool_name
      # @return [String]
      attr_reader :tool_name
      # @!attribute [r] options
      # @return [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      attr_reader :options
    end
  end
end
