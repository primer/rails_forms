# frozen_string_literal: true

module Primer
  module RailsForms
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @input.add_input_classes(
          "FormControl",
          "FormControl--input",
          "FormControl--fullWidth",
          "FormControl--medium"
        )
      end
    end
  end
end
