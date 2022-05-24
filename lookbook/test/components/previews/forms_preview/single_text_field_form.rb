# frozen_string_literal: true

class FormsPreview
  class SingleTextFieldForm < ApplicationForm
    form do |my_form|
      my_form.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        caption: "That which we call a rose by any other name would smell as sweet.",
      )
    end
  end
end
