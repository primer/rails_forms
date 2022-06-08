# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButtonGroup < BaseComponent
      def initialize(input:, builder:, form:)
        @input = input
        @builder = builder
        @form = form
      end
    end
  end
end
