# frozen_string_literal: true

module Primer
  module RailsForms
    class FormControl < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input

        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--input",
          "FormControl--medium",
          "FormControl-fieldWrap--disabled": @input.disabled?,
          "FormControl-fieldWrap--invalid": @input.invalid?
        )
      end
    end
  end
end
