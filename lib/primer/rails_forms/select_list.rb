# frozen_string_literal: true

module Primer
  module RailsForms
    class SelectList < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          "FormField-input",
          "form-select",
          "form-control",
          "width-full",
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )

        @system_arguments[:aria] ||= {}
        @system_arguments[:aria][:required] = true if required?
      end

      def options
        @options ||= @input.options.map do |option|
          [option.label, option.value, option.system_arguments]
        end
      end
    end
  end
end
