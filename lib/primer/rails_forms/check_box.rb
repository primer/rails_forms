# frozen_string_literal: true

module Primer
  module RailsForms
    class CheckBox < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:, **_system_arguments)
        @context = context
        @context.add_input_classes("FormField-input")
      end
    end
  end
end
