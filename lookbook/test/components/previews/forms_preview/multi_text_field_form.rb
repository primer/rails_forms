# frozen_string_literal: true

class FormsPreview
  class MultiTextFieldForm < ApplicationForm
    form do |my_form|
      my_form.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        note: "That which we call a rose by any other name would smell as sweet.",
      )

      my_form.text_field(
        name: :last_name,
        label: "Last name",
        required: true,
        note: "Bueller. Bueller. Bueller.",
      )
    end
  end
end
