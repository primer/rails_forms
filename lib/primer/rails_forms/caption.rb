# frozen_string_literal: true

module Primer
  module RailsForms
    class Caption < BaseComponent
      def initialize(input:, form:, context:)
        @input = input
        @form = form
        @context = context
      end

      def caption_template?
        @form.caption_template?(caption_template_name)
      end

      def render_caption_template
        @form.render_caption_template(caption_template_name)
      end

      def before_render
        return unless @context.caption? && caption_template?

        raise <<~MESSAGE
          Please provide either a caption: argument or caption template for the
          '#{@input.name}' input; both were found.
        MESSAGE
      end

      private

      def caption_template_name
        @caption_template_name ||= if @input.respond_to?(:value)
                                     :"#{@input.name}_#{@input.value}"
                                   else
                                     @input.name.to_sym
                                   end
      end
    end
  end
end
