# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButtonGroup < BaseComponent
      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )
      end
    end
  end
end
