# frozen_string_literal: true

module Primer
  module RailsForms
    class SelectList < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes(
          "FormControl",
          "FormControl--select",
          "FormControl--fullWidth",
          "FormControl--medium"
        )

        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--select",
          "FormControl--medium",
          "FormControl-fieldWrap--disabled": input.disabled?,
          "FormControl-fieldWrap--invalid": input.invalid?
        )
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
