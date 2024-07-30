# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::Generator
  class Generator
    # @param mini_magick_version [String, nil]
    # @param output_dir [String, nil]
    # @return [void]
    def initialize(mini_magick_version:, output_dir:)
      @mini_magick_version = mini_magick_version
      @output_dir = output_dir&.then { Pathname(_1) } ||
                    Bundler.root.join("sig", "rbs_mini_magick") # steep:ignore
      @output_path = @output_dir.join("mini_magick.rbs")
    end

    # @return [void]
    def run
      rbs = Builder.new(mini_magick_version: mini_magick_version).run
      FileUtils.mkdir_p(output_dir.to_s)
      File.write(output_path.to_s, rbs)
    end

    private

    # @!attribute [r] mini_magick_version
    # @return [String, nil]
    attr_reader :mini_magick_version
    # @!attribute [r] output_dir
    # @return [Pathname]
    attr_reader :output_dir
    # @!attribute [r] output_path
    # @return [Pathname]
    attr_reader :output_path
  end
end
