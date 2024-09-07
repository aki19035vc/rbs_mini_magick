# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module Flows
    module Major5Minor0
      class ImageClass
        # @rbs!
        #  include _Flow

        # @rbs override
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
                def initialize: (_ToS input_path, ?Tempfile? tempfile) ?{ (Tool & _Mogrify) -> void } -> void
                              | ...

                def combine_options: () { (Tool & _Mogrify) -> void } -> self
                                   | ...

                def composite: (instance other_image, ?String output_extension, ?untyped? mask) ?{ (Tool & _Composite) -> void } -> instance
                             | ...

                def identify: () ?{ (Tool & _Identify) -> void } -> String
                            | ...

                def mogrify: (?Integer? page) ?{ (Tool & _Mogrify) -> void } -> self
                           | ...

                #{mogrify_methods}
              end
            end
          RBS

          state.concat_rbs(rbs)
        end

        private

        # @rbs (ImageMagick::Option) -> String
        def mogrify_method(option)
          args = option.args_empty? ? "" : "*_ToS args"
          "def #{option.normalized_name}: (#{args}) -> self"
        end
      end
    end
  end
end
