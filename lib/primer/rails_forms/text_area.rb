# frozen_string_literal: true

module Primer
  module RailsForms
    class TextArea < BaseComponent
      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @context = Context.new(input: input, builder: builder, **system_arguments)
        @context.add_input_classes("FormField-input", "form-control", "width-full")
      end
    end
  end
end
