# frozen_string_literal: true

RSpec.describe RbsMiniMagick::Builder do
  subject(:run) { builder.run }

  include_context "with ImageMagick usage mock"

  let(:builder) { described_class.new(mini_magick_version: mini_magick_version) }

  shared_examples "build expected signature" do
    let(:expected) { image_magick_dir.join("mini_magick_#{sig_version}/mini_magick.rbs").read }

    it { is_expected.to eq expected }
  end

  context "when mini_magick_version does not support" do
    let(:mini_magick_version) { "4.13.0" }

    it do
      expect { run }.to raise_error(RbsMiniMagick::Error, "#{mini_magick_version} does not support")
    end
  end

  it_behaves_like "build expected signature" do
    let(:mini_magick_version) { "5.0.0" }
    let(:sig_version) { "5.0" }
  end

  it_behaves_like "build expected signature" do
    let(:mini_magick_version) { "5.0.1" }
    let(:sig_version) { "5.0" }
  end
end
