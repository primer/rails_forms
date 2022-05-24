# frozen_string_literal: true

module Primer
  module RailsForms
    class Base
      class << self
        attr_reader :__vcf_form_block, :__vcf_builder

        def form(&block)
          @__vcf_form_block = block
        end

        def new(builder, **options)
          allocate.tap do |form|
            form.instance_variable_set(:@__vcf_builder, builder)
            form.send(:initialize, **options)
          end
        end
      end

      # **options is unused here, but is present to match the signature of all the
      # other to_component methods in the forms framework
      def to_component(**_options)
        @to_component ||= Primer::RailsForms::Form.new(form_object, @__vcf_builder)
      end

      # Don't use Rails' delegate method here for performance reasons
      # rubocop:disable Rails/Delegate
      def render_in(view_context)
        to_component.render_in(view_context)
      end
      # rubocop:enable Rails/Delegate

      private

      def form_object
        # rubocop:disable Naming/MemoizedInstanceVariableName
        @__vcf_form_object ||= Primer::RailsForms::Dsl::FormObject.new.tap do |node|
          instance_exec(node, &self.class.__vcf_form_block)
        end
        # rubocop:enable Naming/MemoizedInstanceVariableName
      end
    end
  end
end
