# frozen_string_literal: true

class FormsPreview
  class FirstNameForm < ApplicationForm
    form do |first_name_form|
      first_name_form.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        note: "That which we call a rose by any other name would smell as sweet.",
      )
    end
  end

  class LastNameForm < ApplicationForm
    form do |last_name_form|
      last_name_form.text_field(
        name: :last_name,
        label: "Last name",
        required: true,
        note: "Bueller. Bueller. Bueller.",
      )
    end
  end

  class ComposedForm < ApplicationForm
    form do |composed_form|
      composed_form.fields_for(:first_name) do |builder|
        FirstNameForm.new(builder)
      end

      composed_form.fields_for(:last_name) do |builder|
        LastNameForm.new(builder)
      end
    end
  end
end
