# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module Flows
    module Major5Minor0
      class ToolSingleton
        # @rbs!
        #  include _Flow

        # @rbs (name: String) -> void
        def initialize(name:)
          @name = name
        end

        # @rbs override
        def run(state)
          interface_name = "_#{name.capitalize}"
          args = "?errors: bool, ?warnings: bool, ?stdin: _ToS, ?timeout: Integer?, **untyped options"
          rbs = <<~RBS
            module MiniMagick
              def self.#{name}: (#{args}) -> (Tool & #{interface_name})
                              | (#{args}) { (Tool & #{interface_name}) -> void } -> String
                              | ...
            end
          RBS

          state.concat_rbs(rbs)
        end

        private

        attr_reader :name #: String
      end
    end
  end
end
