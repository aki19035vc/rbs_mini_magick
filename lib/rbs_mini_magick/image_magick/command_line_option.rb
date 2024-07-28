# frozen_string_literal: true

module RbsMiniMagick
  module ImageMagick
    # RbsMiniMagick::ImageMagick::CommandLineOption
    class CommandLineOption
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

      # @param return_type [String]
      # @return [String]
      def to_method_signature(return_type)
        sig_args = args.empty? ? "" : "*_ToS args"

        "def #{normalized_name}: (#{sig_args}) -> #{return_type}"
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
