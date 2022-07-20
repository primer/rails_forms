# frozen_string_literal: true

module Primer
  module RailsForms
    class TextField < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        @input.add_input_classes(
          "FormControl-input",
          Dsl::Input::SIZE_MAPPINGS[@input.size]
        )

        @input.add_input_classes("FormControl-inset") if @input.inset?
        @input.add_input_classes("FormControl-monospace") if @input.monospace?

        @field_wrap_classes = class_names(
          "FormControl-input-wrap",
          Dsl::Input::SIZE_MAPPINGS[@input.size],
          "FormControl-input-wrap--trailingAction": @input.show_clear_button?,
          "FormControl-input-wrap--leadingVisual": @input.leading_visual?
        )
      end
    end
  end
end
