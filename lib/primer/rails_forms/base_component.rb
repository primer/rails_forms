# frozen_string_literal: true

require "primer/class_name_helper"

module Primer
  module RailsForms
    class BaseComponent
      include Primer::ClassNameHelper

      TemplateParams = Struct.new(:source, :identifier, :type, :format)

      class << self
        def compile!
          handler = ActionView::Template.handler_for_extension("erb")
          template = File.read(template_path)
          template_params = TemplateParams.new({
            source: template,
            identifier: __FILE__,
            type: "text/html",
            format: "text/html"
          })

          compiled_template = BufferRewriter.rewrite(
            handler.call(template_params, template)
          )

          # rubocop:disable Style/DocumentDynamicEvalDefinition
          # rubocop:disable Style/EvalWithLocation
          class_eval <<-RUBY, template_path, 0
          def render_template
            #{compiled_template}
          end
          RUBY
          # rubocop:enable Style/EvalWithLocation
          # rubocop:enable Style/DocumentDynamicEvalDefinition
        end

        private

        def template_path
          @template_path ||= File.join(__dir__, "#{name.demodulize.underscore}.html.erb")
        end
      end

      delegate :required?, :disabled?, :hidden?, to: :@input
      delegate :render, :content_tag, :output_buffer, :capture, to: :@view_context

      def render_in(view_context)
        @view_context = view_context

        view_context.capture do
          render_template
        end
      end

      private

      def render_template
        self.class.compile!
        render_template
      end
    end
  end
end
