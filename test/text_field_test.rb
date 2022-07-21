# frozen_string_literal: true

require "test_helper"

class TextFieldTest < ActiveSupport::TestCase
  include ViewComponent::TestHelpers

  setup do
    @default_params = {
      name: "foo", id: "foo", label: "Foo"
    }
  end

  test "renders a text input with the given name and ID" do
    render_inline(Primer::TextField.new(**@default_params))

    assert_selector "label.FormControl-label", text: "Foo"
    assert_selector "input[type=text][name=foo][id=foo]"
  end

  test "visually hides the label" do
    render_inline(Primer::TextField.new(**@default_params, show_label: false))

    assert_selector "label.FormControl-label.sr-only", text: "Foo"
  end

  test "renders in the medium size by default" do
    render_inline(Primer::TextField.new(**@default_params))

    assert_selector("input.FormControl-medium")
  end

  test "renders in the large size" do
    render_inline(Primer::TextField.new(**@default_params, size: :large))

    assert_selector("input.FormControl-large")
  end

  test "renders a clear button" do
    render_inline(
      Primer::TextField.new(
        **@default_params,
        show_clear_button: true,
        clear_button_id: "clear-button-id"
      )
    )

    assert_selector "button.FormControl-input-trailingAction#clear-button-id"
  end

  test "renders the component full-width" do
    render_inline(Primer::TextField.new(**@default_params, full_width: true))

    assert_selector ".FormControl--fullWidth input"
  end

  test "marks the input as disabled" do
    render_inline(Primer::TextField.new(**@default_params, disabled: true))

    assert_selector "input[disabled]"
  end

  test "marks the input as invalid" do
    render_inline(Primer::TextField.new(**@default_params, invalid: true))

    assert_selector "input[invalid]"
  end

  test "renders the component with an inset style" do
    render_inline(Primer::TextField.new(**@default_params, inset: true))

    assert_selector "input.FormControl-inset"
  end

  test "renders the component with a monospace font" do
    render_inline(Primer::TextField.new(**@default_params, monospace: true))

    assert_selector "input.FormControl-monospace"
  end

  test "renders a leading visual icon" do
    render_inline(Primer::TextField.new(**@default_params, leading_visual: { icon: :search }))

    assert_selector ".FormControl-input-leadingVisualWrap" do
      assert_selector "svg.octicon.octicon-search"
    end
  end

  test "renders a trailing label" do
    render_inline(Primer::TextField.new(**@default_params, trailing_label: "bar"))

    assert_selector ".d-flex .ml-2", text: "bar"
  end
end
