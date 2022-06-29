# frozen_string_literal: true

module Primer
  module RailsForms
    class TextArea < BaseComponent
      delegate :builder, :form, to: :@input

      def initialize(input:)
        @input = input
        @input.add_input_classes("FormField-input", "form-control", "width-full")
      end
    end
  end
end
