# frozen_string_literal: true

module Primer
  module RailsForms
    class TextField < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context
        @context.add_label_classes("FormControl-label")
        @context.add_input_classes(
          "FormControl",
          "FormControl--input",
          "FormControl--fullWidth",
          "FormControl--medium"
        )
      end
    end
  end
end
