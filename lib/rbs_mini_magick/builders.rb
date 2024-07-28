# frozen_string_literal: true

module RbsMiniMagick
  # RbsMiniMagick::Builders
  module Builders; end
end

require_relative "builders/builder"
require_relative "builders/tool_interface"
require_relative "builders/tool_subclass"
require_relative "builders/singleton_method"
require_relative "builders/image_class"

require_relative "builders/v5_0/builder"
require_relative "builders/v5_0/tool_interface"
require_relative "builders/v5_0/tool_subclass"
require_relative "builders/v5_0/singleton_method"
require_relative "builders/v5_0/image_class"
