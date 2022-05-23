# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class FormObject
        include InputMethods

        def initialize(&block)
          block.call(self) if block
        end

        def group(**options, &block)
          add_input InputGroup.new(**options, &block)
        end
      end
    end
  end
end
