# frozen_string_literal: true

require_relative "lib/rbs_mini_magick/version"

Gem::Specification.new do |spec|
  spec.name = "rbs_mini_magick"
  spec.version = RbsMiniMagick::VERSION
  spec.authors = ["aki19035vc"]
  spec.email = ["52433677+aki19035vc@users.noreply.github.com"]

  spec.summary = "Generate mini_magick signature"
  spec.description = "Generate mini_magick signature"
  spec.homepage = "https://github.com/aki19035vc/rbs_mini_magick"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/aki19035vc/rbs_mini_magick/blob/master/CHANGELOG.md"

  spec.files = Dir["{exe,lib}/**/*", "*.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick", "~> 5.0"
  spec.add_dependency "rbs", ">= 3"
  spec.metadata["rubygems_mfa_required"] = "true"
end
