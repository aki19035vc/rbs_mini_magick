# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::SingletonMethod
    class SingletonMethod
      # @return [String]
      def v5_0
        interface_name = "_#{tool_name.capitalize}"
        args = "?errors: bool, ?warnings: bool, ?stdin: _ToS, ?timeout: Integer?, **untyped options"

        <<~RBS
          def self.#{tool_name}: (#{args}) -> (Tool & #{interface_name}[Tool])
                               | (#{args}) { (Tool & #{interface_name}[Tool]) -> void } -> String
                               | ...
        RBS
      end
    end
  end
end
