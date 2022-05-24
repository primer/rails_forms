# frozen_string_literal: true

module Primer
  module RailsForms
    module Dsl
      module InputMethods
        def fields_for(*args, **kwargs, &block)
          add_input FormReferenceInput.new(*args, **kwargs, &block), decorate: false
        end

        def multi(**options, &block)
          add_input MultiInput.new(**options, &block)
        end

        def hidden(**options)
          add_input HiddenInput.new(**options), decorate: false
        end

        def check_box(**options)
          add_input CheckBoxInput.new(**options)
        end

        def radio_button_group(**options, &block)
          add_input RadioButtonGroupInput.new(**options, &block), decorate: false
        end

        # START text input methods

        def text_field(**options, &block)
          options = decorate_options(**options)
          add_input TextFieldInput.new(**options, &block)
        end

        def text_area(**options, &block)
          options = decorate_options(**options)
          add_input TextAreaInput.new(**options, &block)
        end

        def given_name(**options, &block)
          text_field(autocomplete: "given-name", **options, &block)
        end

        def family_name(**options, &block)
          text_field(autocomplete: "family-name", **options, &block)
        end

        def address_line1(**options, &block)
          text_field(autocomplete: "address-line1", **options, &block)
        end

        def address_line2(**options, &block)
          text_field(autocomplete: "address-line2", **options, &block)
        end

        def address_level2(**options, &block)
          text_field(autocomplete: "address-level2", **options, &block)
        end

        alias city address_level2

        def postal_code(**options, &block)
          text_field(autocomplete: "postal-code", **options, &block)
        end

        # END text input methods

        # START select input methods

        def select_list(**options, &block)
          options = decorate_options(**options)
          add_input SelectListInput.new(**options, &block)
        end

        def country_name(**options, &block)
          select_list(autocomplete: "country-name", **options, &block)
        end

        def address_level1(**options, &block)
          select_list(autocomplete: "address-level1", **options, &block)
        end

        alias region_name address_level1

        # END select input methods

        # START button input methods

        def submit(**options)
          options = decorate_options(**options)
          add_input SubmitButtonInput.new(**options), decorate: false
        end

        # END button input methods

        def inputs
          @inputs ||= []
        end

        private

        def add_input(input, decorate: true)
          input = decorate_input(input) if decorate
          inputs << input
        end

        # Called before the corresponding Input class is instantiated. The return value of this method is passed
        # to the Input class's constructor.
        def decorate_options(**options)
          options
        end

        # Called before the input is added to the list of inputs. This method is expected to return an instance
        # of Input. By default, inputs are decorated with FormControl so they are rendered with a label. See the
        # Multi input for an example of an input that does not perform decoration.
        def decorate_input(input)
          return input if input.type == :group

          FormControlInput.new(base_input: input)
        end
      end
    end
  end
end
