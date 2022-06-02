# frozen_string_literal: true

module Primer
  module RailsForms
    class RadioButtonGroup < BaseComponent
      def initialize(input:, builder:)
        @input = input
        @builder = builder
      end
    end
  end
end
