# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class HiddenInput < Input
        attr_reader :name

        def initialize(name:, **system_arguments)
          @name = name
          @system_arguments = system_arguments
        end

        def to_component(builder:)
          HiddenField.new(input: self, builder: builder, **@system_arguments)
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
