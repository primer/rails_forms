# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonInput < Input
        attr_reader :name, :value, :label, :nested_form_block, :nested_form_arguments, :system_arguments

        def initialize_input(name:, value:, label:, **system_arguments)
          @name = name
          @value = value
          @label = label
          @system_arguments = system_arguments

          yield(self) if block_given?
        end

        def to_component
          RadioButton.new(input: self)
        end

        def nested_form(**system_arguments, &block)
          @nested_form_arguments = system_arguments
          @nested_form_block = block
        end

        def type
          :radio_button
        end
      end
    end
  end
end
