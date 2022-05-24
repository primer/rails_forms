# frozen_string_literal: true

module Primer
  module Experimental
    module Forms
      module Dsl
        class TextAreaInput < Input
          attr_reader :name, :label, :system_arguments

          def initialize(name:, label:, **system_arguments)
            @name = name
            @label = label
            @system_arguments = system_arguments
          end

          def to_component(**options)
            TextArea.new(input: self, **options, **@system_arguments)
          end

          def type
            :text_area
          end
        end
      end
    end
  end
end
