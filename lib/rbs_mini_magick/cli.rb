# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::CLI
  class CLI
    # @param args [Array<String>]
    # @param io [::IO]
    # @return [void]
    def initialize(args, io:)
      @args = args
      @options = {}
      @io = io
    end

    # @return [Integer]
    def run # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      parse!

      return 0 if help? || version?

      case options[:command]
      when "generate"
        Generator.new(
          mini_magick_version: options[:mini_magick_version],
          output_dir: options[:output_dir]
        ).run
      else
        raise ArgumentError, "Invalid command: #{options[:command]}"
      end

      0
    rescue Error => e
      io.puts e.message
      1
    rescue OptionParser::InvalidOption, ArgumentError => e
      io.puts e.message
      io.puts help
      1
    rescue Interrupt
      io.puts "Bye!"
      1
    end

    # @return [String]
    def help
      parser.help
    end

    private

    # @!attribute [r] args
    # @return [Array<String>]
    attr_reader :args
    # @!attribute [r] options
    # @return [Hash]
    attr_reader :options
    # @!attribute [r] io
    # @return [::IO]
    attr_reader :io

    # @return [void]
    # @raise [OptionParser::InvalidOption]
    def parse!
      command = parser.parse(args).first || ""
      @options.merge!(command: command)
    end

    # @return [OptionParser]
    def parser # rubocop:disable Metrics/MethodLength
      OptionParser.new do |opts|
        opts.banner = "Usage: rbs_mini_magick [command] [options]"
        opts.separator <<~COMMANDS
          Commands:
                  generate Generate mini_magick signature
        COMMANDS
        opts.separator("Options:")
        opts.on("--mini-magick-version VALUE", String) { @options[:mini_magick_version] = _1 }
        opts.on("--output-dir VALUE", String) { @options[:output_dir] = _1 }
        opts.on_tail("-h", "--help", "Show help") { @options[:help] = true }
        opts.on_tail("--version", "Show version") { @options[:version] = true }
      end
    end

    # @return [Boolean]
    def help?
      return false unless options.include?(:help)

      io.puts help
      true
    end

    # @return [Boolean]
    def version?
      return false unless options.include?(:version)

      io.puts "RbsMiniMagick: #{RbsMiniMagick::VERSION}"
      true
    end
  end
end
