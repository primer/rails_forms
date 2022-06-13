# frozen_string_literal: true

module Primer
  module RailsForms
    class Caption < BaseComponent
      delegate :input, to: :@context

      def initialize(context:)
        @context = context
      end

      def caption_template?
        @context.caption_template?
      end

      def render_caption_template
        @context.render_caption_template
      end

      def before_render
        return unless @context.caption? && caption_template?

        raise <<~MESSAGE
          Please provide either a caption: argument or caption template for the
          '#{input.name}' input; both were found.
        MESSAGE
      end
    end
  end
end
