# frozen_string_literal: true

module Primer
  module RailsForms
    class Multi < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @system_arguments = system_arguments
      end
    end
  end
end
