# frozen_string_literal: true

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::Major5Minor0
    module Major5Minor0
      # RbsMiniMagick::Flows::Major5Minor0::ToolInterface
      class ToolInterface
        # @param name [String]
        # @return [void]
        def initialize(name:)
          @name = name
        end

        # @param state [RbsMiniMagick::Flows::State]
        # @return [RbsMiniMagick::Flows::State]
        def run(state) # rubocop:disable Metrics/MethodLength
          tool_usage = state.fetch_tool_usage(name)
          interface_name = "_#{name.capitalize}"
          option_methods = tool_usage.options
                                     .map { option_method(_1) }
                                     .uniq.join("\n")
          rbs = <<~RBS
            module MiniMagick
              interface #{interface_name}
                #{option_methods}
              end
            end
          RBS

          state.concat_rbs(rbs)
        end

        private

        # @!attribute [r] name
        # @return [String]
        attr_reader :name

        # @param option [RbsMiniMagick::ImageMagick::Option]
        # @return [String]
        def option_method(option)
          args = option.args_empty? ? "" : "*_ToS args"

          "def #{option.normalized_name}: (#{args}) -> self"
        end
      end
    end
  end
end
