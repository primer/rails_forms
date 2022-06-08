# frozen_string_literal: true

class FriendForm < ApplicationForm
  form do |friend_form|
    friend_form.group(layout: :horizontal) do |name_group|
      name_group.text_field(name: "first_name", label: "First Name")
      name_group.text_field(name: "last_name", label: "Last Name")
    end
  end
end

class RadioButtonWithNestedForm < ApplicationForm
  form do |radio_form|
    radio_form.radio_button_group(name: "channel") do |radio_group|
      radio_group.radio_button(value: "online", label: "Online advertisement", caption: "Facebook maybe?")
      radio_group.radio_button(value: "radio", label: "Radio advertisement", caption: "We love us some NPR")
      radio_group.radio_button(value: "friend", label: "From a friend", caption: "Wow, what a good person") do |friend_button|
        friend_button.nested_form do |builder|
          FriendForm.new(builder)
        end
      end
    end
  end
end
