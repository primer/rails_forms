# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class TextAreaInput < Input
        attr_reader :name, :label, :system_arguments

        def initialize_input(name:, label:, **system_arguments)
          @name = name
          @label = label
          @system_arguments = system_arguments
        end

        def to_component
          TextArea.new(input: self)
        end

        def type
          :text_area
        end

        def focusable?
          true
        end
      end
    end
  end
end
