# frozen_string_literal: true

module Primer
  module RailsForms
    class HiddenField < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context
        @context.add_input_classes("FormField-input")
      end
    end
  end
end
