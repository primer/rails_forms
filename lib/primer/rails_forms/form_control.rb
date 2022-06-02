# frozen_string_literal: true

module Primer
  module RailsForms
    class FormControl < BaseComponent
      def initialize(input:, builder:, context:)
        @input = input
        @builder = builder
        @context = context
      end
    end
  end
end
