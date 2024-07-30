# frozen_string_literal: true

require "bundler/setup"
require "bundler/gem_tasks"

require "pathname"
require "rbs_mini_magick"

desc "Generate mini_magick sig for test"
task :generate_mini_magick_sig, %w[version] do |_, args|
  mini_magick_version = args["version"]
  output_dir = Pathname(__dir__).join(
    "spec/support/data",
    "image_magick_#{MiniMagick.cli_version}",
    "mini_magick_#{mini_magick_version}"
  )
  cli_args = ["generate", "--mini-magick-version", mini_magick_version, "--output-dir", output_dir.to_s]

  FileUtils.mkdir_p(output_dir)
  RbsMiniMagick::CLI.new(cli_args, io: $stdout).run.zero? &&
    puts("Generate mini_magick sig => #{output_dir}")
end

desc "Store ImageMagick usages for test"
task :store_image_magick_usages do
  output_dir = Pathname(__dir__).join("spec/support/data/image_magick_#{MiniMagick.cli_version}/usages")
  FileUtils.mkdir_p(output_dir)
  RbsMiniMagick::Flows::Major5Minor0::TOOL_NAMES.each do |tool_name|
    File.write(
      output_dir.join("#{tool_name}.txt"),
      RbsMiniMagick::ImageMagick::UsageFetcher.new(tool_name: tool_name).run
    )
  end
  puts "Store ImageMagick usages => #{output_dir}"
end

# @param version [String]
# @return [Integer]
def typecheck_any_version(version) # rubocop:disable Metrics/MethodLength
  chdir = Pathname("#{__dir__}/typecheck/#{version}")
  unless chdir.exist?
    puts "#{chdir} does not exist"
    return 1
  end

  system("bundle", "exec", "rbs", "collection", "install", "--frozen", chdir: chdir.to_s)

  if system("bundle", "exec", "steep", "check", "-j2", chdir: chdir.to_s)
    puts "Typecheck succeeded for version #{version}"
    0
  else
    puts "Typecheck failed for version #{version}"
    1
  end
end

namespace :typecheck do
  require "steep"
  require "steep/cli"

  desc "Typecheck for lib dir"
  task :lib do
    system("bundle", "exec", "steep", "check", chdir: __dir__) || exit(1)
  end

  desc "Typecheck for typecheck/<version> dir"
  task :any_version, ["version"] do |_, args|
    typecheck_any_version(args["version"]).then { exit _1 }
  end

  desc "Typecheck for all typecheck/<version> dirs"
  task :all_versions, ["version"] do |_, _args|
    %w[5.0].map do |version|
      puts "=" * 100
      typecheck_any_version(version)
    end.all?(&:zero?) || exit(1)
  end
end

desc "Generate and Check code documents"
task :yard do
  require "yard"
  YARD::CLI::CommandParser.run
  output = `yard`.lines(chomp: true)
  exit(1) if output.first.include?("[warn]") || output.last.match(/\d+/)[0].to_i != 100
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:rspec)

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = %w[--parallel]
end
