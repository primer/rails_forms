# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class Input
        def name
          raise_for_abstract_method!(__method__)
        end

        def label
          raise_for_abstract_method!(__method__)
        end

        def type
          raise_for_abstract_method!(__method__)
        end

        def system_arguments
          raise_for_abstract_method!(__method__)
        end

        def to_component(**_options)
          raise_for_abstract_method!(__method__)
        end

        def hidden?
          !!system_arguments[:hidden]
        end

        def required?
          !!system_arguments[:required]
        end

        private

        def raise_for_abstract_method!(method_name)
          raise NotImplementedError, "subclasses must implement ##{method_name}."
        end
      end
    end
  end
end
