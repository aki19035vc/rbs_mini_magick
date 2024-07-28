# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::ToolInterface
    class ToolInterface
      # @return [String]
      def v5_0
        tool_methods = options.map { _1.to_method_signature("[T]") }
                              .uniq.join("\n")

        <<~RBS
          interface _#{tool_name.capitalize}[T]
            #{tool_methods}
          end
        RBS
      end
    end
  end
end
