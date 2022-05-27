# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonGroupInput < Input
        attr_reader :name, :label, :system_arguments, :radio_buttons

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @system_arguments = system_arguments
          @radio_buttons = []

          yield(self) if block_given?
        end

        def label
          nil
        end

        def to_component(**options)
          RadioButtonGroup.new(input: self, **options, **@system_arguments)
        end

        def type
          :radio_button_group
        end

        def radio_button(**system_arguments)
          @radio_buttons << FormControlInput.new(
            base_input: RadioButtonInput.new(name: @name, **system_arguments)
          )
        end
      end
    end
  end
end
