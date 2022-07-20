# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class TextFieldInput < Input
        attr_reader *%i[
          name label show_clear_button leading_visual trailing_label
          clear_button_id visually_hide_label inset monospace
        ]

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label

          @show_clear_button = system_arguments.delete(:show_clear_button)
          @leading_visual = system_arguments.delete(:leading_visual)
          @trailing_label = system_arguments.delete(:trailing_label)
          @clear_button_id = system_arguments.delete(:clear_button_id)
          @inset = system_arguments.delete(:inset)
          @monospace = system_arguments.delete(:monospace)

          super(**system_arguments)
        end

        alias show_clear_button? show_clear_button
        alias inset? inset
        alias monospace? monospace

        def to_component
          TextField.new(input: self)
        end

        def type
          :text_field
        end

        def focusable?
          true
        end

        def leading_visual?
          !!@leading_visual
        end
      end
    end
  end
end
