# frozen_string_literal: true

class SubmitButtonForm < ApplicationForm
  form do |my_form|
    my_form.fields_for(:name_form) do |builder|
      MultiTextFieldForm.new(builder)
    end

    my_form.submit(name: :submit, label: "Submit")
  end
end
