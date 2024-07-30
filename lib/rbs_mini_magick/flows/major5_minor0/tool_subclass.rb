# frozen_string_literal: true

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::Major5Minor0
    module Major5Minor0
      # RbsMiniMagick::Flows::Major5Minor0::ToolSubclass
      class ToolSubclass
        # @param name [String]
        # @return [void]
        def initialize(name:)
          @name = name
        end

        # @param state [RbsMiniMagick::Flows::State]
        # @return [RbsMiniMagick::Flows::State]
        def run(state) # rubocop:disable Metrics/MethodLength
          capitalized_name = name.capitalize
          rbs = <<~RBS
            module MiniMagick
              class Tool
                class #{capitalized_name} < Tool
                  include _#{capitalized_name}
                end
              end
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
