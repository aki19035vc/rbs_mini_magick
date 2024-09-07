# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module Flows
    module Major5Minor0
      class ToolInterface
        # @rbs!
        #  include _Flow

        # @rbs (name: String) -> void
        def initialize(name:)
          @name = name
        end

        # @rbs override
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

        attr_reader :name #: String

        # @rbs (ImageMagick::Option) -> String
        def option_method(option)
          args = option.args_empty? ? "" : "*_ToS args"

          "def #{option.normalized_name}: (#{args}) -> self"
        end
      end
    end
  end
end
