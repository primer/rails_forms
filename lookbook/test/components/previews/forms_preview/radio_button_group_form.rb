# frozen_string_literal: true

class FormsPreview
  class RadioButtonGroupForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: "channel", label: "How did you hear about us?") do |radio_group|
        radio_group.radio_button(label: "Online advertisement")
        radio_group.radio_button(label: "Radio advertisement")
        radio_group.radio_button(label: "From a friend")
      end
    end
  end
end
