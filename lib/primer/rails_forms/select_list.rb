# frozen_string_literal: true

module Primer
  module RailsForms
    class SelectList < BaseComponent
      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @context = Context.new(input: input, builder: builder, **system_arguments)
        @context.add_input_classes("FormField-input", "form-select", "form-control", "width-full")
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
