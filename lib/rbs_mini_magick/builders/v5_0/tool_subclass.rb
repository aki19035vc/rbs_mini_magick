# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::ToolSubclass
    class ToolSubclass
      # @return [String]
      def v5_0
        <<~RBS
          class Tool
            class #{tool_name.capitalize} < Tool
              include _#{tool_name.capitalize}
            end
          end
        RBS
      end
    end
  end
end
