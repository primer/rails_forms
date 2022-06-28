# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class HiddenInput < Input
        attr_reader :name

        def initialize_input(name:, **system_arguments)
          @name = name
          @system_arguments = system_arguments
        end

        def to_component
          HiddenField.new(input: self)
        end

        def label
          nil
        end

        def type
          :hidden
        end
      end
    end
  end
end
