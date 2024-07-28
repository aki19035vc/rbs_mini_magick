# frozen_string_literal: true

RSpec.describe RbsMiniMagick::CLI do
  let(:cli) { described_class.new(args, io: io) }
  let(:io) { StringIO.new }

  shared_examples "runnable" do
    let(:run) { cli.run }
    let(:log) { io.tap(&:rewind).readlines.map(&:chomp) }

    it do # rubocop:disable RSpec/MultipleExpectations
      expect(run).to eq expected_return
      expect(log).to eq expected_log
    end
  end

  context "when a non-existent command is specified" do
    let(:args) { ["foo"] }

    it_behaves_like "runnable" do
      let(:expected_return) { 1 }
      let(:expected_log) { ["Invalid command: foo"] + cli.help.split("\n") }
    end
  end

  context "when --help is specified" do
    let(:args) { ["--help"] }

    it_behaves_like "runnable" do
      let(:expected_return) { 0 }
      let(:expected_log) { cli.help.split("\n") }
    end
  end

  context "when --version is specified" do
    let(:args) { ["--version"] }

    it_behaves_like "runnable" do
      let(:expected_return) { 0 }
      let(:expected_log) { ["RbsMiniMagick: #{RbsMiniMagick::VERSION}"] }
    end
  end

  context "when generate is specified" do
    include_context "with tmpdir"
    include_context "with data dir"
    include_context "with ImageMagick usage mock"

    let(:args) { ["generate", "--mini-magick-version", "5.0", "--output-dir", tmp_dir] }

    it_behaves_like "runnable" do
      let(:expected_return) { 0 }
      let(:expected_log) { [] }
    end

    it do
      cli.run
      actual = Pathname(tmp_dir).join("mini_magick.rbs").read
      expected = image_magick_dir.join("mini_magick_5.0/mini_magick.rbs").read
      expect(actual).to eq expected
    end
  end
end
