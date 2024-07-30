# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::Builder
  class Builder
    # @param mini_magick_version [String, nil]
    # @return [void]
    def initialize(mini_magick_version:)
      @mini_magick_version = mini_magick_version&.then { Gem::Version.new(_1) } ||
                             MiniMagick.version
    end

    # @return [String]
    def run
      tool_names, flows = tool_names_and_flows
      initial_state = Flows::State.init(tool_usages: build_tool_usages(tool_names))
      completed_state = flows.reduce(initial_state) { |state, flow| flow.run(state) }

      completed_state.formated_rbs
    end

    private

    # @!attribute [r] mini_magick_version
    # @return [Gem::Version]
    attr_reader :mini_magick_version

    # @return [Array]
    def tool_names_and_flows
      case mini_magick_version
      when Range.new(Gem::Version.new("5.0"), nil)
        [Flows::Major5Minor0::TOOL_NAMES, Flows::Major5Minor0::FLOWS]
      else
        raise Error, "#{mini_magick_version} does not support"
      end
    end

    # @param tool_names [Array<String>]
    # @return [Array<RbsMiniMagick::ImageMagick::ToolUsage>]
    def build_tool_usages(tool_names)
      tool_names.map do |tool_name|
        raw_usage = ImageMagick::UsageFetcher.new(tool_name: tool_name).run
        ImageMagick::ToolUsage.build_by_raw_usage(tool_name, raw_usage)
      end
    end
  end
end
