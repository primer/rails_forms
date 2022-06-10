# frozen_string_literal: true

module Primer
  module RailsForms
    class FormControl < BaseComponent
      def initialize(input:, builder:, form:, context:)
        @input = input
        @builder = builder
        @form = form
        @context = context
      end
    end
  end
end
