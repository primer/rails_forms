# frozen_string_literal: true

module Primer
  module RailsForms
    class FormReference < BaseComponent
      def initialize(input:, builder:)
        @input = input
        @builder = builder
      end
    end
  end
end
