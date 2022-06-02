# frozen_string_literal: true

class FormsPreview
  class RadioButtonGroupForm < ApplicationForm
    form do |radio_form|
      radio_form.radio_button_group(name: "channel") do |radio_group|
        radio_group.radio_button(value: "online", label: "Online advertisement", caption: "Facebook maybe?")
        radio_group.radio_button(value: "radio", label: "Radio advertisement", caption: "We love us some NPR")
        radio_group.radio_button(value: "friend", label: "From a friend", caption: "Wow, what a good person")
      end
    end
  end
end
