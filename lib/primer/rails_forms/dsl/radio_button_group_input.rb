# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonGroupInput < Input
        attr_reader :name, :radio_buttons

        def initialize(name:, **system_arguments)
          @name = name
          @radio_buttons = []

          super(**system_arguments)

          yield(self) if block_given?
        end

        def to_component
          RadioButtonGroup.new(input: self)
        end

        def label
          nil
        end

        def type
          :radio_button_group
        end

        def radio_button(**system_arguments, &block)
          @radio_buttons << RadioButtonInput.new(
            builder: @builder, form: @form, name: @name, **system_arguments, &block
          )
        end
      end
    end
  end
end
