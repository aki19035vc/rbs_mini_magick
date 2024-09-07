# frozen_string_literal: true

# rbs_inline: enabled

module RbsMiniMagick
  class Generator
    # @rbs (mini_magick_version: String?, output_dir: String?) -> void
    def initialize(mini_magick_version:, output_dir:)
      @mini_magick_version = mini_magick_version
      @output_dir = output_dir&.then { Pathname(_1) } ||
                    Bundler.root.join("sig", "rbs_mini_magick") # steep:ignore
      @output_path = @output_dir.join("mini_magick.rbs")
    end

    # @rbs () -> void
    def run
      rbs = Builder.new(mini_magick_version: mini_magick_version).run
      FileUtils.mkdir_p(output_dir.to_s)
      File.write(output_path.to_s, rbs)
    end

    private

    attr_reader :mini_magick_version #: String?
    attr_reader :output_dir #: Pathname
    attr_reader :output_path #: Pathname
  end
end
