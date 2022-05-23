# frozen_string_literal: true

module Primer
  module RailsForms
    class CheckBox < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          "FormField-input",
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )

        @system_arguments[:aria] ||= {}
        @system_arguments[:aria][:required] = true if required?
      end
    end
  end
end
