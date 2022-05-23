# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class TextFieldInput < Input
        attr_reader :name, :label, :system_arguments

        def initialize(name:, label:, multi_line: false, **system_arguments)
          @name = name
          @label = label
          @multi_line = multi_line
          @system_arguments = system_arguments
        end

        def multi_line?
          !!@multi_line
        end

        def to_component(**options)
          if multi_line?
            TextArea.new(input: self, **options, **@system_arguments)
          else
            TextField.new(input: self, **options, **@system_arguments)
          end
        end

        def type
          :text_field
        end
      end
    end
  end
end
