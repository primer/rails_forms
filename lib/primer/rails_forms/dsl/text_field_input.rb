# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class TextFieldInput < Input
        attr_reader :name, :label

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          super(**system_arguments)
        end

        def to_component
          TextField.new(input: self)
        end

        def type
          :text_field
        end

        def focusable?
          true
        end
      end
    end
  end
end
