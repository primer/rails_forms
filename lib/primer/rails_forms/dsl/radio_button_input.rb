# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class RadioButtonInput < Input
        attr_reader :name, :value, :label, :system_arguments

        def initialize(name:, value:, label:, **system_arguments)
          @name = name
          @value = value
          @label = label
          @system_arguments = system_arguments
        end

        def to_component(**options)
          RadioButton.new(input: self, **options, **@system_arguments)
        end

        def type
          :radio_button
        end
      end
    end
  end
end
