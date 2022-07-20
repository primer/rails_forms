# frozen_string_literal: true

module Primer
  class FormComponents
    def self.from_input(input_klass)
      Class.new(ViewComponent::Base) do
        @input_klass = input_klass

        class << self
          attr_reader :input_klass
        end

        def initialize(**kwargs, &block)
          @kwargs = kwargs
          @block = block
        end

        def call
          builder = ActionView::Helpers::FormBuilder.new(nil, nil, self, {})

          input = self.class.input_klass.new(
            builder: builder,
            form: nil,
            **@kwargs,
            &@block
          )

          input.render_in(self) { content }
        end
      end
    end
  end

  # These components are designed to be used outside the context of a form object.
  # They can be rendered just like any other View Component and accept the same
  # arguments as the form input they wrap.
  #
  # Eg:
  #
  # render(
  #   TextFieldComponent.new(
  #     name: "foo",
  #     label: "Foo",
  #     caption: "Something about foos"
  #   )
  # )
  #
  TextFieldComponent = FormComponents.from_input(Primer::RailsForms::Dsl::TextFieldInput)
end
