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

        @system_arguments[:class] = class_names(
          @system_arguments.delete(:class),
          @system_arguments.delete(:classes),
          horizontal? ? "gutter-condensed" : "",
          wrapper_classes
        )
        @system_arguments.delete(:class) unless @system_arguments[:class].present?

        @input_arguments = {
          class: class_names(input_classes)
        }
        @input_arguments.delete(:class) unless @input_arguments[:class].present?
      end

      def horizontal?
        @layout == HORIZONTAL
      end

      private

      def content_tag_if_args(tag, **args, &block)
        if args.empty?
          capture(&block)
        else
          content_tag(tag, **args, &block)
        end
      end

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
