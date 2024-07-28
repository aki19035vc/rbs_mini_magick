# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::SingletonMethod
    class SingletonMethod
      # @param tool_name [String]
      # @return [void]
      def initialize(tool_name:)
        @tool_name = tool_name
      end

      private

      # @!attribute [r] tool_name
      # @return [String]
      attr_reader :tool_name
    end
  end
end
