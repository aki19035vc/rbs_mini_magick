# frozen_string_literal: true

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::Major5Minor0
    module Major5Minor0
      # RbsMiniMagick::Flows::Major5Minor0::ToolSingleton
      class ToolSingleton
        # @param name [String]
        # @return [void]
        def initialize(name:)
          @name = name
        end

        # @param state [RbsMiniMagick::Flows::State]
        # @return [RbsMiniMagick::Flows::State]
        def run(state)
          interface_name = "_#{name.capitalize}"
          args = "?errors: bool, ?warnings: bool, ?stdin: _ToS, ?timeout: Integer?, **untyped options"
          rbs = <<~RBS
            module MiniMagick
              def self.#{name}: (#{args}) -> (Tool & #{interface_name}[Tool])
                              | (#{args}) { (Tool & #{interface_name}[Tool]) -> void } -> String
                              | ...
            end
          RBS

          state.concat_rbs(rbs)
        end

        private

        # @!attribute [r] name
        # @return [String]
        attr_reader :name
      end
    end
  end
end
