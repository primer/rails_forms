# frozen_string_literal: true

module Primer
  module RailsForms
    class Base
      extend ActsAsComponent

      renders_template File.join(__dir__, "base.html.erb"), :render_base_form

      class << self
        attr_reader :has_after_content, :__vcf_form_block, :__vcf_builder
        alias after_content? has_after_content

        def form(&block)
          @__vcf_form_block = block
        end

        def new(builder, **options)
          allocate.tap do |form|
            form.instance_variable_set(:@builder, builder)
            form.send(:initialize, **options)
          end
        end

        def inherited(base)
          form_path = const_source_location(base.name)
          return unless form_path

          base.template_root_path = File.join(File.dirname(form_path), base.name.demodulize.underscore)

          base.renders_template "after_content.html.erb" do
            base.instance_variable_set(:@has_after_content, true)
          end

          base.renders_templates "*_caption.html.erb" do |path|
            base.fields_with_caption_templates << File.basename(path).chomp("_caption.html.erb").to_sym
          end
        end

        def caption_template?(field_name)
          fields_with_caption_templates.include?(field_name)
        end

        def fields_with_caption_templates
          @fields_with_caption_templates ||= []
        end

        private

        # Unfortunately this bug (https://github.com/ruby/ruby/pull/5646) prevents us from using
        # Ruby's native Module.const_source_location. Instead we have to fudge it by searching
        # for the file in the configured autoload paths. Doing so relies on Rails' autoloading
        # conventions, so it should work ok. Zeitwerk also has this information but lacks a
        # public API to map constants to source files.
        def const_source_location(class_name)
          # NOTE: underscore respects namespacing, i.e. will convert Foo::Bar to foo/bar.
          class_path = "#{class_name.underscore}.rb"

          ActiveSupport::Dependencies.autoload_paths.each do |autoload_path|
            absolute_path = File.join(autoload_path, class_path)
            return absolute_path if File.exist?(absolute_path)
          end

          nil
        end
      end

      def each_input
        return enum_for(__method__) unless block_given?

        # wrap inputs in a group (unless they are already groups)
        form_object.inputs.each do |input|
          if input.type == :group
            yield input
          else
            yield(Primer::RailsForms::Dsl::InputGroup.new do |group|
              group.send(:add_input, input)
            end)
          end
        end
      end

      def caption_template?(*args)
        self.class.caption_template?(*args)
      end

      def after_content?(*args)
        self.class.after_content?(*args)
      end

      def render_caption_template(name)
        send(:"render_#{name}_caption")
      end

      def perform_render(&_block)
        Base.compile!
        self.class.compile!

        render_base_form
      end

      private

      def form_object
        # rubocop:disable Naming/MemoizedInstanceVariableName
        @__vcf_form_object ||= Primer::RailsForms::Dsl::FormObject.new.tap do |obj|
          instance_exec(obj, &self.class.__vcf_form_block)
        end
        # rubocop:enable Naming/MemoizedInstanceVariableName
      end
    end
  end
end
