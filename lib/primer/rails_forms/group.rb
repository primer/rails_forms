# frozen_string_literal: true

require "primer/classify"

module Primer
  module RailsForms
    class Group < BaseComponent
      VERTICAL = :vertical
      HORIZONTAL = :horizontal
      DEFAULT_LAYOUT = VERTICAL
      LAYOUTS = [VERTICAL, HORIZONTAL].freeze

      def initialize(inputs:, builder:, layout: DEFAULT_LAYOUT, **system_arguments)
        @inputs = inputs
        @builder = builder
        @layout = layout
        @system_arguments = system_arguments
      end

      def horizontal?
        @layout == HORIZONTAL
      end

      private

      def col_width
        @col_width ||= 12 / @inputs.size
      end

      def input_classes
        @input_classes ||= classify({}.tap do |h|
          h[:float] = :left if horizontal?
          h[:col] = col_width if horizontal?
        end)
      end

      def wrapper_classes
        @wrapper_classes ||= classify({}.tap do |h|
          h[:clearfix] = true if horizontal?
        end)
      end

      def classify(hash)
        Primer::Classify.call(hash)[:class]
      end
    end
  end
end
