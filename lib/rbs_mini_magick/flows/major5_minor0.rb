# frozen_string_literal: true

# rbs_inline: enabled

require_relative "major5_minor0/tool_interface"
require_relative "major5_minor0/tool_singleton"
require_relative "major5_minor0/tool_subclass"
require_relative "major5_minor0/image_class"

module RbsMiniMagick
  module Flows
    module Major5Minor0
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
      ].freeze #: Array[String]
      public_constant :TOOL_NAMES

      # @return [Array<#run>]
      FLOWS = [
        *TOOL_NAMES.map { ToolInterface.new(name: _1) },
        *TOOL_NAMES.map { ToolSingleton.new(name: _1) },
        *TOOL_NAMES.map { ToolSubclass.new(name: _1) },
        ImageClass.new
      ].freeze #: Array[_Flow]
      public_constant :FLOWS
    end
  end
end
