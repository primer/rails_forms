# frozen_string_literal: true

module Primer
  module RailsForms
    class TextArea < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context
        @context.add_input_classes("FormField-input", "form-control", "width-full")
      end
    end
  end
end
