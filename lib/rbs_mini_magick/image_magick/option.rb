# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  module ImageMagick
    class Option
      attr_reader :normalized_name #: String

      # @rbs (name: String, args: Array[String]) -> void
      def initialize(name:, args:)
        @name = name
        @args = args
        @normalized_name = name.delete_prefix("-").gsub(/\W/, "_")
      end

      # @rbs () -> bool
      def args_empty?
        args.empty?
      end

      private

      attr_reader :name #: String
      attr_reader :args #: Array[String]
    end
  end
end
