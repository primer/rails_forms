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
    end
  end
end
