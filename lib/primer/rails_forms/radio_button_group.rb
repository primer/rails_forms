# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButtonGroup < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context
      end
    end
  end
end
