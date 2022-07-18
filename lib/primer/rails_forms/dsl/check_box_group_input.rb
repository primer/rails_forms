# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class CheckBoxGroupInput < Input
        attr_reader :check_boxes

        def initialize(**system_arguments)
          @check_boxes = []

          super(**system_arguments)

          yield(self) if block_given?
        end

        def to_component
          CheckBoxGroup.new(input: self)
        end

        def name
          nil
        end

        def label
          nil
        end

        def type
          :check_box_group
        end

        def check_box(**system_arguments)
          @check_boxes << CheckBoxInput.new(
            builder: @builder, form: @form, **system_arguments
          )
        end
      end
    end
  end
end
