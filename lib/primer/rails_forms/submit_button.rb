# frozen_string_literal: true

module Primer
  module RailsForms
    class SubmitButton < BaseComponent
      delegate :input, :builder, :form, to: :@context

      def initialize(context:)
        @context = context
        @context.add_input_classes("FormField-input", "btn-primary", "btn")

        # Never disable submit buttons. This overrides the global
        # ActionView::Base.automatically_disable_submit_tag setting.
        # Disabling the submit button is not accessible.
        @context.add_input_data(:disable_with, false)
      end
    end
  end
end
