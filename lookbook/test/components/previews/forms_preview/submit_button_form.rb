# frozen_string_literal: true

class FormsPreview
  class SubmitButtonForm < ApplicationForm
    form do |my_form|
      my_form.fields_for(:name_form) do |builder|
        MultiTextFieldForm.new(builder)
      end

      my_form.submit(label: "Submit")
    end
  end
end
