# frozen_string_literal: true

module RbsMiniMagick
  module Builders
    # RbsMiniMagick::Builder
    class Builder
      # @return [String]
      def v5_0 # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        tool_interface_methods = options_by_tool.map do |tool, options|
          Builders::ToolInterface.new(tool_name: tool, options: options).v5_0
        end.join("\n")

        tool_subclasses = options_by_tool.map do |tool, _|
          Builders::ToolSubclass.new(tool_name: tool).v5_0
        end.join("\n")

        singleton_methods = options_by_tool.map do |tool, _|
          Builders::SingletonMethod.new(tool_name: tool).v5_0
        end.join("\n")

        image_class = Builders::ImageClass.new(mogrify_options: mogrify_options).v5_0

        <<~RBS
          module MiniMagick
            #{tool_interface_methods}

            #{tool_subclasses}

            #{singleton_methods}

            #{image_class}
          end
        RBS
      end
    end
  end
end
