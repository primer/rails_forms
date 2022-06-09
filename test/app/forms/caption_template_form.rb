# frozen_string_literal: true

class CaptionTemplateForm < ApplicationForm
  form do |name_form|
    name_form.text_field(
      name: :first_name,
      label: "First name",
      required: true
    )

    name_form.check_box(
      name: :cool,
      label: "Are you cool?"
    )
  end
end
