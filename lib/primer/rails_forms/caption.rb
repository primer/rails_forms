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
        @form.caption_template?(@input.name)
      end

      def render_caption_template
        @form.render_caption_template(@input.name)
      end

      def before_render
        return unless @context.caption? && caption_template?

        raise <<~MESSAGE
          Please provide either a caption: argument or caption template for the
          '#{@input.name}' input; both were found.
        MESSAGE
      end
    end
  end
end
