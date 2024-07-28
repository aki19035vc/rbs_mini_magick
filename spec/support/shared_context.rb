# frozen_string_literal: true

require "tmpdir"

shared_context "with tmpdir" do
  let(:tmp_dir) { Dir.mktmpdir }

  around do |example|
    tmp_dir
    example.run
    FileUtils.remove_entry_secure tmp_dir
  end
end

shared_context "with data dir" do
  let(:data_dir) { Pathname(__dir__).join("data") }
end

shared_context "with ImageMagick usage mock" do
  include_context "with data dir"

  let(:image_magick_version) { "7.1.1-29" }
  let(:image_magick_dir) { data_dir.join("image_magick_#{image_magick_version}") }

  before do
    RbsMiniMagick::ImageMagick::TOOL_NAMES.each do |tool_name|
      usage = image_magick_dir.join("usages/#{tool_name}.txt").read
      fetcher = instance_double(RbsMiniMagick::ImageMagick::UsageFetcher)
      allow(fetcher).to receive(:run).and_return(usage)
      allow(RbsMiniMagick::ImageMagick::UsageFetcher).to(
        receive(:new).with(tool_name: tool_name).and_return(fetcher)
      )
    end
  end
end
