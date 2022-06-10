# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      class FormReferenceInput < Input
        attr_reader :ref_block, :fields_for_args, :fields_for_kwargs

        def initialize(*fields_for_args, **fields_for_kwargs, &block)
          @fields_for_args = fields_for_args
          @fields_for_kwargs = fields_for_kwargs
          @ref_block = block
        end

        def to_component(builder:, form:, **options)
          FormReference.new(input: self, builder: builder, form: form, **options)
        end

        def name
          nil
        end

        def label
          nil
        end

        def type
          :form
        end
      end
    end
  end
end
