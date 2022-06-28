# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class SubmitButtonInput < Input
        attr_reader :name, :label, :system_arguments, :block

        def initialize_input(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @system_arguments = system_arguments
          @block = block
        end

        def to_component
          SubmitButton.new(input: self)
        end

        def type
          :submit_button
        end
      end
    end
  end
end
