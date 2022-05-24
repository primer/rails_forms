# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class InputGroup
        include InputMethods

        attr_reader :system_arguments

        def initialize(**system_arguments)
          @system_arguments = system_arguments

          yield(self) if block_given?
        end

        def type
          :group
        end
      end
    end
  end
end
