# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class SubmitButtonInput < Input
        attr_reader :label, :system_arguments

        def initialize(label:, **system_arguments)
          @label = label
          @system_arguments = system_arguments
        end

        def to_component(builder:, form:)
          SubmitButton.new(context: Context.make(self, builder, form, **@system_arguments))
        end

        def name
          nil
        end

        def type
          :submit_button
        end
      end
    end
  end
end
