# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class CheckBoxInput < Input
        attr_reader :name, :label, :system_arguments

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @system_arguments = system_arguments
        end

        def to_component(**options)
          CheckBox.new(input: self, **options, **@system_arguments)
        end

        def type
          :check_box
        end
      end
    end
  end
end
