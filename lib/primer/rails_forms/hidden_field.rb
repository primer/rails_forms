# frozen_string_literal: true

module Primer
  module RailsForms
    class HiddenField < BaseComponent
      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @system_arguments = system_arguments
        @system_arguments[:class] = class_names(
          "FormField-input",
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )
      end
    end
  end
end
