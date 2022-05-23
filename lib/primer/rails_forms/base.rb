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
        @component ||= Primer::RailsForms::Form.new(form_object, @__vcf_builder)
      end

      def render_in(view_context)
        to_component.render_in(view_context)
      end

      private

      def form_object
        @__vcf_form_object ||= Primer::RailsForms::Dsl::FormObject.new.tap do |node|
          instance_exec(node, &self.class.__vcf_form_block)
        end
      end
    end
  end
end
