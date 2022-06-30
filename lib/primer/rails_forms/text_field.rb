# frozen_string_literal: true

module Primer
  module RailsForms
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_label_classes("FormControl-label")
        @input.add_input_classes(
          "FormControl-input",
          "FormControl--medium"
        )

        @field_wrap_classes = class_names("FormControl-input-wrap")
        @trailing_label = @input.input_arguments.delete(:trailing_label)
      end
    end
  end
end
