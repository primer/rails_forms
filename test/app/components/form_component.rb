# frozen_string_literal: true

class FormComponent < ViewComponent::Base
  def initialize(form_class:)
    @form_class = form_class
  end
end
