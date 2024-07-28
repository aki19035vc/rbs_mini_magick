# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::ImageClass
    class ImageClass
      # @return [String]
      def v5_0
        <<~RBS
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

            #{delegated_mogrify_methods.join("\n")}
          end
        RBS
      end
    end
  end
end
