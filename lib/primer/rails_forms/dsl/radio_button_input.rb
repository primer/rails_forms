# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonInput < Input
        attr_reader :name, :value, :label, :nested_form_block, :nested_form_arguments

        def initialize(name:, value:, label:, **system_arguments)
          @name = name
          @value = value
          @label = label

          super(**system_arguments)

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
