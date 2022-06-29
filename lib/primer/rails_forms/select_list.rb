# frozen_string_literal: true

module Primer
  module RailsForms
    class SelectList < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormField-input", "form-select", "form-control", "width-full")
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
