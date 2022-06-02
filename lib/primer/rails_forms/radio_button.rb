# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButton < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @context = Context.new(input: input, builder: builder, **system_arguments)
        @context.add_input_classes("FormField-input")
      end
    end
  end
end
