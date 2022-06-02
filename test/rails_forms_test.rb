# frozen_string_literal: true

require "test_helper"

class RailsFormsTest < ActiveSupport::TestCase
  include ViewComponent::TestHelpers

  class DeepThought
    include ActiveModel::API
    include ActiveModel::Validations

    attr_reader :ultimate_answer

    def initialize(ultimate_answer)
      @ultimate_answer = ultimate_answer
    end

    validates :ultimate_answer, comparison: { greater_than: 41, less_than: 43 }
  end

  setup do
    @single_text_field_form = Class.new(ApplicationForm) do
      form do |my_form|
        my_form.text_field(
          name: :ultimate_answer,
          label: "Ultimate answer",
          required: true,
          caption: "The answer to life, the universe, and everything"
        )
      end
    end

    @checkbox_form = Class.new(ApplicationForm) do
      form do |my_form|
        my_form.check_box(
          name: :enable_ipd,
          label: "Enable the Infinite Improbability Drive",
          caption: "Cross interstellar distances in a mere nothingth of a second."
        )
      end
    end
  end

  test "renders correct form structure" do
    single_text_field_form = @single_text_field_form

    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        render(single_text_field_form.new(f))
      end
    end

    assert_selector "form[action='/foo']" do
      assert_selector ".form-group" do
        assert_selector ".form-group-header" do
          assert_selector "label[for='ultimate_answer']", text: "Ultimate answer" do
            # asterisk for required field
            assert_selector "span[aria-hidden='true']", text: "*"
          end
        end

        assert_selector ".form-group-body" do
          assert_selector "input[type='text'][name='ultimate_answer'][id='ultimate_answer'][required='required']"
        end
      end
    end
  end

  test "renders correct form structure for a checkbox" do
    checkbox_form = @checkbox_form

    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        render(checkbox_form.new(f))
      end
    end

    assert_selector ".form-checkbox" do
      assert_selector "label[for='enable_ipd']", text: "Enable the Infinite Improbability Drive" do
        assert_selector "input[type='checkbox'][name='enable_ipd'][id='enable_ipd']"
        assert_selector ".note", text: "Cross interstellar distances in a mere nothingth of a second."
      end
    end
  end

  test "includes the given note" do
    single_text_field_form = @single_text_field_form

    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        render(single_text_field_form.new(f))
      end
    end

    assert_selector ".form-group .note", text: "The answer to life, the universe, and everything"
  end

  test "the input is described by the caption" do
    single_text_field_form = @single_text_field_form

    render_in_view_context do
      form_with(url: "/foo", skip_default_ids: false) do |f|
        render(single_text_field_form.new(f))
      end
    end

    caption_id = page.find_css(".note").attribute("id").value
    assert_selector "input[aria-describedby='#{caption_id}']"
  end

  test "includes activemodel validation messages" do
    single_text_field_form = @single_text_field_form
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      form_with(model: model, url: "/foo", skip_default_ids: false) do |f|
        render(single_text_field_form.new(f))
      end
    end

    assert_selector ".form-group" do
      assert_selector ".color-fg-danger", text: "Ultimate answer must be greater than 41" do
        assert_selector ".octicon-alert-fill"
      end
    end
  end

  test "the input is described by the validation message" do
    single_text_field_form = @single_text_field_form
    model = DeepThought.new(41)
    model.valid? # populate validation error messages

    render_in_view_context do
      form_with(model: model, url: "/foo", skip_default_ids: false) do |f|
        render(single_text_field_form.new(f))
      end
    end

    validation_id = page.find_css(".color-fg-danger").attribute("id").value
    described_by = page.find_css("input[type='text']").attribute("aria-describedby").value
    assert described_by.split.include?(validation_id)
  end

  test "renders correctly inside a view component" do
    checkbox_form = @checkbox_form

    render_in_view_context do
      render(FormComponent.new(form_class: checkbox_form))
    end

    assert_selector "label input"
  end
end
