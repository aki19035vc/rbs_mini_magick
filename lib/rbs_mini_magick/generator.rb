# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::Generator
  class Generator
    # @param mini_magick_version [Gem::Version, nil]
    # @param output_dir [String, nil]
    # @return [void]
    def initialize(mini_magick_version:, output_dir:)
      @mini_magick_version = mini_magick_version || MiniMagick.version
      @output_path = (
        output_dir&.then { Pathname(_1) } ||
        Bundler.root.join("sig", "rbs_mini_magick") # steep:ignore
      ).join("mini_magick.rbs")
    end

    # @return [void]
    def run
      rbs = Builders::Builder.new(mini_magick_version: mini_magick_version).run
      File.write(output_path.to_s, rbs)
    end

    private

    # @!attribute [r] mini_magick_version
    # @return [Gem::Version]
    attr_reader :mini_magick_version
    # @!attribute [r] output_path
    # @return [Pathname]
    attr_reader :output_path
  end
end
