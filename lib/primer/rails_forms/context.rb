# frozen_string_literal: true

require "primer/class_name_helper"
require "securerandom"

module Primer
  module RailsForms
    class Context
      SPACE_DELIMITED_ARIA_ATTRIBUTES = %i(describedby).freeze

      include Primer::ClassNameHelper

      attr_reader *%i(
        input builder input_arguments label_arguments caption validation_message ids
      )

      def initialize(input:, builder:, **system_arguments)
        @input = input
        @builder = builder

        @input_arguments = system_arguments

        @label_arguments = @input_arguments.delete(:label_arguments) || {}
        @label_arguments[:class] = class_names(
          @label_arguments.delete(:class),
          @label_arguments.delete(:classes),
          @input_arguments.fetch(:show_label, true) ? nil : "sr-only"
        )

        @input_arguments.delete(:show_label)
        @label_arguments.delete(:class) if @label_arguments[:class].empty?

        @caption = @input_arguments.delete(:caption)
        @validation_message = @input_arguments.delete(:validation_message)

        base_id = SecureRandom.hex[0..5]

        @ids = {}.tap do |id_map|
          id_map[:validation] = "validation-#{base_id}" if invalid?
          id_map[:caption] = "caption-#{base_id}" if caption?
        end

        add_input_aria(:required, true) if required?
        add_input_aria(:describedby, ids.values) if ids.any?
      end

      def add_input_classes(*class_names)
        input_arguments[:class] = class_names(
          input_arguments[:class], *class_names
        )
      end

      def add_input_aria(key, value)
        @input_arguments[:aria] ||= {}

        if space_delimited_aria_attribute?(key)
          @input_arguments[:aria][key] = aria_join(@input_arguments[:aria][key], *Array(value))
        else
          @input_arguments[:aria][key] = value
        end
      end

      def validation_id
        ids[:validation]
      end

      def caption_id
        ids[:caption]
      end

      def caption?
        caption.present?
      end

      def valid?
        validation_messages.empty?
      end

      def invalid?
        !valid?
      end

      def hidden?
        !!input_arguments[:hidden]
      end

      def required?
        !!input_arguments[:required]
      end

      def validation_messages
        validation_messages ||=
          if validation_message
            [validation_message]
          elsif builder.object.respond_to?(:errors)
            builder.object.errors.full_messages_for(input.name)
          else
            []
          end
      end

      private

      def space_delimited_aria_attribute?(attrib)
        SPACE_DELIMITED_ARIA_ATTRIBUTES.include?(attrib)
      end

      def aria_join(*values)
        values = values.flat_map { |v| v.to_s.split(" ") }
        values.reject! { |v| v.empty? }
        values.join(" ")
      end
    end
  end
end
