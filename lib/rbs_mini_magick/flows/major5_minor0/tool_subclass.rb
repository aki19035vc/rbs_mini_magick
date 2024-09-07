# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module Flows
    module Major5Minor0
      class ToolSubclass
        # @rbs!
        #  include _Flow

        # @rbs (name: String) -> void
        def initialize(name:)
          @name = name
        end

        # @rbs override
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

        attr_reader :name #: String
      end
    end
  end
end
