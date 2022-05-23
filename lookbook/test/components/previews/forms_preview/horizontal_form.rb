# frozen_string_literal: true

class FormsPreview
  class HorizontalForm < ApplicationForm
    form do |my_form|
      my_form.group(layout: :horizontal) do |name_group|
        name_group.text_field(
          name: :first_name,
          label: "First name",
          required: true,
          note: "What your friends call you.",
        )

        name_group.text_field(
          name: :last_name,
          label: "Last name",
          required: true,
          note: "What the principal calls you.",
        )
      end

      my_form.text_field(
        name: :dietary_restrictions,
        label: "Dietary restrictions",
        note: "Any allergies?",
      )

      my_form.check_box(
        name: :email_notifications,
        label: "Send me gobs of email!",
        note: "Check this if you enjoy getting spam."
      )
    end
  end
end
