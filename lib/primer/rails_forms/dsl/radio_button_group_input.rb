# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonGroupInput < Input
        attr_reader :name, :system_arguments
        attr_reader :radio_buttons

        def initialize(name:, **system_arguments, &block)
          @name = name
          @system_arguments = system_arguments
          @radio_buttons = []

          block.call(self) if block
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
