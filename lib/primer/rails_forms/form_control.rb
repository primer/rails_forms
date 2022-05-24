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

        @note = @input.system_arguments.delete(:note)
        @validation_message = @input.system_arguments.delete(:validation_message)
        @validation_id = "validation-#{SecureRandom.hex[0..5]}"
        @aria_attributes = @input.system_arguments.delete(:aria) || {}
        @aria_attributes[:describedby] = @validation_id
      end

      private

      def valid?
        validation_messages.empty?
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
