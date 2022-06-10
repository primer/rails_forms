# frozen_string_literal: true

module Primer
  module RailsForms
    class Multi < BaseComponent
      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @system_arguments = system_arguments
      end
    end
  end
end
