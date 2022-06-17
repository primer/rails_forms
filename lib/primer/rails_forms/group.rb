# frozen_string_literal: true

require "primer/classify"

module Primer
  module RailsForms
    class Group < BaseComponent
      VERTICAL = :vertical
      HORIZONTAL = :horizontal
      DEFAULT_LAYOUT = VERTICAL
      LAYOUTS = [VERTICAL, HORIZONTAL].freeze

      def initialize(inputs:, builder:, form:, layout: DEFAULT_LAYOUT, **system_arguments)
        @inputs = inputs
        @builder = builder
        @form = form
        @layout = layout
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          @system_arguments.delete(:class),
          @system_arguments.delete(:classes),
          horizontal? ? "gutter-condensed" : "",
          wrapper_classes
        )
        @system_arguments.delete(:class) if @system_arguments[:class].blank?

        @input_arguments = {
          class: class_names(input_classes)
        }
        @input_arguments.delete(:class) if @input_arguments[:class].blank?
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
          h[:col] = col_width if horizontal?
        end)
      end

      def wrapper_classes
        @wrapper_classes ||= classify({}.tap do |h|
          h[:display] = :flex if horizontal?
        end)
      end

      def classify(hash)
        Primer::Classify.call(hash)[:class]
      end
    end
  end
end
