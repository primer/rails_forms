# frozen_string_literal: true

require "primer/class_name_helper"
require "securerandom"

module Primer
  module RailsForms
    class Context
      SPACE_DELIMITED_ARIA_ATTRIBUTES = %i[describedby].freeze

      include Primer::ClassNameHelper

      attr_reader :input, :builder, :form, :input_arguments, :label_arguments, :caption, :validation_message, :ids

      def self.make(input, builder, form, **system_arguments)
        new(input: input, builder: builder, form: form, **system_arguments)
      end

      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form

        @input_arguments = system_arguments

        @input_arguments[:class] = class_names(
          @input_arguments.delete(:class),
          @input_arguments.delete(:classes)
        )

        @label_arguments = @input_arguments.delete(:label_arguments) || {}
        @label_arguments[:class] = class_names(
          @label_arguments.delete(:class),
          @label_arguments.delete(:classes),
          @input_arguments.fetch(:show_label, true) ? nil : "sr-only"
        )

        @input_arguments.delete(:show_label)
        @input_arguments.delete(:class) if @input_arguments[:class].blank?
        @label_arguments.delete(:class) if @label_arguments[:class].blank?

        @caption = @input_arguments.delete(:caption)
        @validation_message = @input_arguments.delete(:validation_message)

        base_id = SecureRandom.hex[0..5]

        @ids = {}.tap do |id_map|
          id_map[:validation] = "validation-#{base_id}" if invalid?
          id_map[:caption] = "caption-#{base_id}" if caption? || caption_template?
        end

        add_input_aria(:required, true) if required?
        add_input_aria(:describedby, ids.values) if ids.any?
      end

      def add_input_classes(*class_names)
        input_arguments[:class] = class_names(
          input_arguments[:class], *class_names
        )
      end

      def add_label_classes(*class_names)
        label_arguments[:class] = class_names(
          label_arguments[:class], *class_names
        )
      end

      def add_input_aria(key, value)
        @input_arguments[:aria] ||= {}

        @input_arguments[:aria][key] = if space_delimited_aria_attribute?(key)
                                         aria_join(@input_arguments[:aria][key], *Array(value))
                                       else
                                         value
                                       end
      end

      def add_input_data(key, value)
        @input_arguments[:data] ||= {}
        @input_arguments[:data][key] = value
      end

      def merge_input_arguments!(arguments)
        arguments.each do |k, v|
          case k
          when :class, :classes, "class", "classes"
            add_input_classes(v)
          when :aria, "aria"
            v.each do |aria_k, aria_v|
              add_input_aria(aria_k, aria_v)
            end
          when :data, "data"
            v.each do |data_k, data_v|
              add_input_data(data_k, data_v)
            end
          else
            @input_arguments[k] = v
          end
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

      def caption_template?
        form.caption_template?(caption_template_name)
      end

      def render_caption_template
        form.render_caption_template(caption_template_name)
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
        @validation_messages ||=
          if validation_message
            [validation_message]
          elsif builder.object.respond_to?(:errors)
            builder.object.errors.full_messages_for(input.name)
          else
            []
          end
      end

      def disabled?
        @input_arguments.include?(:disabled)
      end

      private

      def caption_template_name
        @caption_template_name ||= if input.respond_to?(:value)
                                     :"#{input.name}_#{input.value}"
                                   else
                                     input.name.to_sym
                                   end
      end

      def space_delimited_aria_attribute?(attrib)
        SPACE_DELIMITED_ARIA_ATTRIBUTES.include?(attrib)
      end

      def aria_join(*values)
        values = values.flat_map { |v| v.to_s.split }
        values.reject!(&:empty?)
        values.join(" ")
      end
    end
  end
end
