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

        def initialize(name:, label:, **system_arguments)
          @name = name
          @label = label
          @options = []
          @system_arguments = system_arguments

          yield(self) if block_given?
        end

        def option(**system_arguments)
          @options << Option.new(**system_arguments)
        end

        def to_component(builder:, form:)
          SelectList.new(input: self, builder: builder, form: form, **@system_arguments)
        end

        def type
          :select_list
        end
      end
    end
  end
end
