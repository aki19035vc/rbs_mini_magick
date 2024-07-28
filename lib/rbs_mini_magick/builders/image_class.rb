# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builders::ImageClass
    class ImageClass
      # @param mogrify_options [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      # @return [void]
      def initialize(mogrify_options:)
        @mogrify_options = mogrify_options
      end

      private

      # @!attribute [r] mogrify_options
      # @return [Array<RbsMiniMagick::ImageMagick::CommandLineOption>]
      attr_reader :mogrify_options

      # @return [Array<String>]
      def delegated_mogrify_methods
        image_instance_methods = MiniMagick::Image.instance_methods.to_set(&:to_s)

        mogrify_options.filter_map do |item|
          next if image_instance_methods.include?(item.normalized_name)

          item.to_method_signature("self")
        end.uniq
      end
    end
  end
end
