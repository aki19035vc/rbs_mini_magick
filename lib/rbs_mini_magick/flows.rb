# frozen_string_literal: true

# rbs_inline: enabled

require_relative "flows/state"
require_relative "flows/major5_minor0"

module RbsMiniMagick
  module Flows
    # @rbs!
    #   interface _Flow
    #     def run: (Flows::State) -> State
    #   end
  end
end
