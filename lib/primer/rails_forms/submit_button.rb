# frozen_string_literal: true

module Primer
  module RailsForms
    class SubmitButton < BaseComponent
      def initialize(input:, builder:, form:, **system_arguments)
        @input = input
        @builder = builder
        @form = form
        @system_arguments = system_arguments

        @system_arguments[:class] = class_names(
          "FormField-input",
          "btn-primary",
          "btn",
          @system_arguments[:class],
          @system_arguments.delete(:classes)
        )

        # Never disable submit buttons. This overrides the global
        # ActionView::Base.automatically_disable_submit_tag setting.
        # Disabling the submit button is not accessible.
        @system_arguments[:data] = {
          **(system_arguments[:data] || {}),
          disable_with: false
        }
      end
    end
  end
end
