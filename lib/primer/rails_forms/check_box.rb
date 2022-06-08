# frozen_string_literal: true

module Primer
  module RailsForms
    class CheckBox < BaseComponent
      attr_reader :context

      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @context = Context.new(input: input, builder: builder, **system_arguments)
        @context.add_input_classes("FormField-input")
      end
    end
  end
end
