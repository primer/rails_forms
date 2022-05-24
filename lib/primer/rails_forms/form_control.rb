# frozen_string_literal: true

require "securerandom"

module Primer
  module RailsForms
    class FormControl < BaseComponent
      def initialize(input:, builder:)
        @input = input
        @builder = builder

        @label_arguments = {
          class: class_names(
            @input.system_arguments.delete(:label_classes),
            @input.system_arguments.fetch(:show_label, true) ? "" : "sr-only"
          )
        }

        @input.system_arguments.delete(:show_label)
        @label_arguments.delete(:class) if @label_arguments[:class].empty?

        @caption = @input.system_arguments.delete(:caption)
        @validation_message = @input.system_arguments.delete(:validation_message)
        @aria_attributes = @input.system_arguments.delete(:aria) || {}

        base_id = SecureRandom.hex[0..5]

        @ids = {}.tap do |id_map|
          id_map[:validation] = "validation-#{base_id}" if invalid?
          id_map[:caption] = "caption-#{base_id}" if caption?
        end

        return if @ids.empty?

        @aria_attributes[:describedby] = @ids.values.join(" ")
      end

      def validation_id
        @ids[:validation]
      end

      def caption_id
        @ids[:caption]
      end

      def caption?
        @caption.present?
      end

      private

      def valid?
        validation_messages.empty?
      end

      def invalid?
        !valid?
      end

      def validation_messages
        @validation_messages ||=
          if @validation_message
            [@validation_message]
          elsif @builder.object.respond_to?(:errors)
            @builder.object.errors.full_messages_for(@input.name)
          else
            []
          end
      end
    end
  end
end
