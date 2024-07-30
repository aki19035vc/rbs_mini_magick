# frozen_string_literal: true

module RbsMiniMagick
  module ImageMagick
    # RbsMiniMagick::ImageMagick::Option
    class Option
      # @!attribute [r] normalized_name
      # @return [String]
      attr_reader :normalized_name

      # @param name [String]
      # @param args [Array<String>]
      # @return [void]
      def initialize(name:, args:)
        @name = name
        @args = args
        @normalized_name = name.delete_prefix("-").gsub(/\W/, "_")
      end

      # @return [Boolean]
      def args_empty?
        args.empty?
      end

      private

      # @!attribute [r] name
      # @return [String]
      attr_reader :name
      # @!attribute [r] args
      # @return [Array<String>]
      attr_reader :args
    end
  end
end
