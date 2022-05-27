# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButton < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          "FormField-input",
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )

        if required?
          @system_arguments[:aria] ||= {}
          @system_arguments[:aria][:required] = true
        end
      end
    end
  end
end
