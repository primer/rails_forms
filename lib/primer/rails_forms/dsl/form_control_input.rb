# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class FormControlInput < Input
        delegate :name, :label, :type, :system_arguments, to: :@base_input

        def initialize(base_input:)
          @base_input = base_input
        end

        def to_component(**options)
          FormControl.new(input: @base_input, **options)
        end
      end
    end
  end
end
