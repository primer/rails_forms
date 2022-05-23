# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class MultiInput < Input
        include InputMethods

        attr_reader :name, :label, :system_arguments

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @system_arguments = system_arguments

          block.call(self) if block
        end

        def to_component(**options)
          Multi.new(input: self, **options, **@system_arguments)
        end

        def type
          :multi
        end

        private

        def add_input(input)
          super

          check_one_input_visible!
        end

        def decorate_input(input)
          input
        end

        def decorate_options(name: nil, **options)
          check_name!(name) if name
          new_options = { name: name || @name, label: nil, **options }
          new_options[:id] = nil if options[:hidden]
          new_options
        end

        def check_name!(name)
          if name != @name
            raise ArgumentError, "Inputs inside a `multi' block must all have the same name. Expected '#{@name}', got '#{name}'."
          end
        end

        def check_one_input_visible!
          return if inputs.count { |input| !input.hidden? } <= 1

          raise ArgumentError, "Only one input can be visible at a time in a `multi' block."
        end
      end
    end
  end
end
