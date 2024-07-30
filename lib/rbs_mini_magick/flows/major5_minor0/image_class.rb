# frozen_string_literal: true

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::Major5Minor0
    module Major5Minor0
      # RbsMiniMagick::Flows::Major5Minor0::ImageClass
      class ImageClass
        # @param state [RbsMiniMagick::Flows::State]
        # @return [RbsMiniMagick::Flows::State]
        def run(state) # rubocop:disable Metrics/MethodLength
          image_instance_methods = MiniMagick::Image.instance_methods.to_set(&:to_s)
          mogrify_methods = state.fetch_tool_usage("mogrify")
                                 .options
                                 .reject { image_instance_methods.include?(_1.normalized_name) }
                                 .map { mogrify_method(_1) }
                                 .uniq.join("\n")
          rbs = <<~RBS
            module MiniMagick
              class Image
                def initialize: (_ToS input_path, ?Tempfile? tempfile) ?{ (Tool & _Mogrify[Tool]) -> void } -> void
                              | ...

                def combine_options: () { (Tool & _Mogrify[Tool]) -> void } -> self
                                   | ...

                def composite: (instance other_image, ?String output_extension, ?untyped? mask) ?{ (Tool & _Composite[Tool]) -> void } -> instance
                             | ...

                def identify: () ?{ (Tool & _Identify[Tool]) -> void } -> String
                            | ...

                def mogrify: (?Integer? page) ?{ (Tool & _Mogrify[Tool]) -> void } -> self
                           | ...

                #{mogrify_methods}
              end
            end
          RBS

          state.concat_rbs(rbs)
        end

        private

        # @param option [RbsMiniMagick::ImageMagick::Option]
        # @return [String]
        def mogrify_method(option)
          args = option.args_empty? ? "" : "*_ToS args"
          "def #{option.normalized_name}: (#{args}) -> self"
        end
      end
    end
  end
end
