# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class CheckBoxGroupInput
        attr_reader :items

        def initialize(node:, **system_arguments, &block)
          @items = []
          @node = node
          @system_arguments = system_arguments

          instance_eval(&block)
        end

        def item(name:, body:, **system_arguments)
          items << CheckBoxInput.new(
            node: @node,
            name: name,
            body: body,
            group: self,
            **system_arguments
          )
        end
      end
    end
  end
end
