# frozen_string_literal: true

require_relative "major5_minor0/tool_interface"
require_relative "major5_minor0/tool_singleton"
require_relative "major5_minor0/tool_subclass"
require_relative "major5_minor0/image_class"

module RbsMiniMagick
  module Flows
    # RbsMiniMagick::Flows::Major5Minor0
    module Major5Minor0
      # @return [String<String>]
      TOOL_NAMES = %w[
        animate
        compare
        composite
        conjure
        convert
        display
        identify
        import
        mogrify
        montage
        stream
      ].freeze
      public_constant :TOOL_NAMES

      # @return [Array<#run>]
      FLOWS = [
        *TOOL_NAMES.map { ToolInterface.new(name: _1) },
        *TOOL_NAMES.map { ToolSingleton.new(name: _1) },
        *TOOL_NAMES.map { ToolSubclass.new(name: _1) },
        ImageClass.new
      ].freeze
      public_constant :FLOWS
    end
  end
end
