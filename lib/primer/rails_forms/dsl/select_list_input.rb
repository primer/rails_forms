# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class SelectListInput < Input
        class Option
          attr_reader :label, :value, :system_arguments

          def initialize(label:, value:, **system_arguments)
            @label = label
            @value = value
            @system_arguments = system_arguments
          end
        end

        attr_reader :name, :label, :options, :system_arguments

        def initialize(name:, label:, **system_arguments, &block)
          @name = name
          @label = label
          @options = []
          @system_arguments = system_arguments

          block.call(self) if block
        end

        def option(**system_arguments)
          @options << Option.new(**system_arguments)
        end

        def to_component(**options)
          SelectList.new(input: self, **options, **@system_arguments)
        end

        def type
          :select_list
        end
      end
    end
  end
end
