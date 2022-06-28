# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class CheckBoxInput < Input
        attr_reader :name, :label, :system_arguments

        def initialize_input(name:, label:, **system_arguments)
          @name = name
          @label = label
          @system_arguments = system_arguments
        end

        def to_component
          CheckBox.new(input: self)
        end

        def type
          :check_box
        end
      end
    end
  end
end
