# frozen_string_literal: true

module Primer
  module RailsForms
    class FormControl < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context

        @field_wrap_classes = class_names(
          "FormControl-fieldWrap",
          "FormControl-fieldWrap--input",
          "FormControl--medium",
          "FormControl-fieldWrap--disabled": context.disabled?,
          "FormControl-fieldWrap--invalid": context.invalid?
        )
      end
    end
  end
end
