# frozen_string_literal: true

module Primer
  module RailsForms
    class Form < BaseComponent
      def initialize(form_object, builder)
        @form_object = form_object
        @builder = builder
      end

      def each_input
        return enum_for(__method__) unless block_given?

        # wrap inputs in a group (unless they are already groups)
        @form_object.inputs.each do |input|
          if input.type == :group
            group = input
            yield Group.new(inputs: group.inputs, builder: @builder, **group.system_arguments)
          else
            yield Group.new(inputs: [input], builder: @builder)
          end
        end
      end
    end
  end
end
