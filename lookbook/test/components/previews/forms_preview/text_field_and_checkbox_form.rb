# frozen_string_literal: true

class FormsPreview
  class TextFieldAndCheckboxForm < ApplicationForm
    form do |my_form|
      my_form.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        note: "That which we call a rose by any other name would smell as sweet.",
      )

      my_form.check_box(
        name: :is_human,
        label: "Are you human?",
        note: "Check this unless you're a Cylon."
      )
    end
  end
end
