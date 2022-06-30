# frozen_string_literal: true

require "test_helper"

class FormsTest < ActiveSupport::TestCase
  include ViewComponent::TestHelpers
  include ViewComponent::RenderPreviewHelper

  class DeepThought
    include ActiveModel::API
    include ActiveModel::Validations

    attr_reader :ultimate_answer

    def initialize(ultimate_answer)
      @ultimate_answer = ultimate_answer
    end

    validates :ultimate_answer, comparison: { greater_than: 41, less_than: 43 }
  end

  test "renders correct form structure" do
    render_preview(:single_text_field_form)

    assert_selector "form[action='/foo']" do
      assert_selector ".form-group" do
        assert_selector ".form-group-header" do
          assert_selector "label[for='ultimate_answer']", text: "Ultimate answer" do
            # asterisk for required field
            assert_selector "span[aria-hidden='true']", text: "*"
          end
        end

        assert_selector ".form-group-body" do
          assert_selector "input[type='text'][name='ultimate_answer'][id='ultimate_answer'][aria-required='true']"
        end
      end
    end
  end

  test "renders correct form structure for a checkbox" do
    render_preview(:text_field_and_checkbox_form)

    assert_selector ".form-checkbox" do
      assert_selector "label[for='enable_ipd']", text: "Enable the Infinite Improbability Drive" do
        assert_selector "input[type='checkbox'][name='enable_ipd'][id='enable_ipd']"
        assert_selector ".note", text: "Cross interstellar distances in a mere nothingth of a second."
      end
    end
  end

  test "includes the given note" do
    render_preview(:single_text_field_form)

    assert_selector ".form-group .note", text: "The answer to life, the universe, and everything"
  end

  test "the input is described by the caption" do
    render_preview(:single_text_field_form)

    caption_id = page.find_css(".note").attribute("id").value
    assert_selector "input[aria-describedby='#{caption_id}']"
  end

  test "includes activemodel validation messages" do
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      form_with(model: model, url: "/foo", skip_default_ids: false) do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    assert_selector ".form-group" do
      assert_selector ".color-fg-danger", text: "Ultimate answer must be greater than 41" do
        assert_selector ".octicon-alert-fill"
      end
    end
  end

  test "names inputs correctly when rendered against an activemodel" do
    model = DeepThought.new(42)

    render_in_view_context do
      form_with(model: model, url: "/foo", skip_default_ids: false) do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    text_field = page.find_css("input[type=text]").first
    assert_equal text_field.attribute("name").value, "forms_test_deep_thought[ultimate_answer]"
  end

  test "the input is described by the validation message" do
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      form_with(model: model, url: "/foo", skip_default_ids: false) do |f|
        render(SingleTextFieldForm.new(f))
      end
    end

    validation_id = page.find_css(".color-fg-danger").attribute("id").value
    described_by = page.find_css("input[type='text']").attribute("aria-describedby").value
    assert described_by.split.include?(validation_id)
  end

  test "renders correctly inside a view component" do
    render_inline(FormComponent.new(form_class: TextFieldAndCheckboxForm))

    assert_selector "form label input"
  end

  test "renders the caption template when present" do
    render_preview :caption_template_form

    assert_selector ".note .color-fg-danger", text: "Be honest!"
    assert_selector ".note .color-fg-danger", text: "Check only if you are cool."
    assert_selector ".note .color-fg-danger", text: "A young thing."
    assert_selector ".note .color-fg-danger", text: "No longer a spring chicken."
  end

  test "the input is described by the caption when caption templates are used" do
    num_inputs = 4
    render_preview :caption_template_form

    caption_ids = page
                  .find_css(".note")
                  .map { |note| note.attribute("id").value }
                  .reject(&:empty?)
                  .uniq

    assert caption_ids.size == num_inputs, "Expected #{num_inputs} unique caption IDs, got #{caption_ids.size}"

    assert_selector("input", count: num_inputs) do |input|
      caption_id = input["aria-describedby"]
      assert_includes caption_ids, caption_id
      caption_ids.delete(caption_id)
    end

    assert_empty caption_ids
  end

  test "renders content after the form when present" do
    render_preview :after_content_form

    assert_selector ".content-after"
  end

  test "raises an error if both a caption argument and a caption template are provided" do
    error = assert_raises RuntimeError do
      render_in_view_context do
        form_with(url: "/foo", skip_default_ids: false) do |f|
          render(BothTypesOfCaptionForm.new(f))
        end
      end
    end

    assert_includes error.message, "Please provide either a caption: argument or caption template"
  end

  test "form list renders multiple forms" do
    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        render(Primer::RailsForms::FormList.new(FirstNameForm.new(f), LastNameForm.new(f)))
      end
    end

    assert_selector "input[type=text][name=first_name]"
    assert_selector "input[type=text][name=last_name]"
  end

  test "renders a submit button" do
    render_preview :submit_button_form

    assert_selector "button[type=submit]"
  end

  test "renders a submit button without data-disable-with" do
    render_preview :submit_button_form

    button = page.find_css("button[type=submit]").first
    assert_nil button.attributes["data-disable-with"]
  end

  test "autofocuses the first invalid input" do
    render_preview :invalid_form

    assert_selector "input[type=text][name=last_name][autofocus]"
  end
end
