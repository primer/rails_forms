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

        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--input",
          "FormControl--medium",
          "FormControl-fieldWrap--disabled": @input.disabled?,
          "FormControl-fieldWrap--invalid": @input.invalid?
        )

        @trailing_label = @input.input_arguments.delete(:trailing_label)
      end
    end
  end
end
