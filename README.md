# primer_rails_forms

Easily create Rails forms in a declarative manner.

## What is this thing?

This repo contains the library code for the Rails forms framework as well as an app containing a [Lookbook](https://github.com/allmarkedup/lookbook) for demonstrating forms functionality.

Our goal with this project is to make forms accessible by default. In service of this goal, customization options are limited. If you've run into a use-case that requires functionality the framework does not yet support, please file an issue or reach out to a team member in the #primer-rails Slack channel.

## Usage

For the impatient, here's an example form that showcases much of the framework's functionality.

```ruby
class SignUpForm < ApplicationForm
  form do |sign_up_form|
    sign_up_form.group(layout: :horizontal) do |name_group|
      name_group.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        caption: "What your friends call you.",
      )

      name_group.text_field(
        name: :last_name,
        label: "Last name",
        required: true,
        caption: "What the principal calls you.",
      )
    end

    sign_up_form.text_field(
      name: :dietary_restrictions,
      label: "Dietary restrictions",
      caption: "Any allergies?",
    )

    if @show_notifications_checkbox
      sign_up_form.check_box(
        name: :email_notifications,
        label: "Send me gobs of email!",
        caption: "Check this if you enjoy getting spam."
      )
    end

    sign_up_form.submit(label: "Submit")
  end

  def initialize(show_notifications_checkbox: true)
    @show_notifications_checkbox = show_notifications_checkbox
  end
end
```

### Form classes

A number of the concepts present in primer/rails_forms are borrowed from the [view_component](https://github.com/github/view_component) framework. Like view components, forms are declared inside classes that inherit from a common base class, `Primer::RailsForms::Base`.

### Application-specific base class

It's a good idea to create an `ApplicationForm` base class inside your application as we have done inside GitHub's monolith (dotcom). A separate, application-specific base class allows your team to add shared functionality to all forms without the need to modify `Primer::RailsForms::Base` or make changes to each individual form class.

Place the following code in app/forms/application_form.rb:

```ruby
class ApplicationForm < Primer::RailsForms::Base
end
```

All the examples in this README assume the existence of `ApplicationForm`.

### Declaring forms

Forms are declared inside the block passed to the `form` class method. The method yields an instance of `Primer::RailsForms::Dsl::FormObject` and responds to a number of form input methods which are described below.

### Input methods

1. `text_field`. A single-line text field. Results in an HTML `<input type="text">` tag.
   Arguments:
   `name: String`, _required_. The name to associate with this input. Appears in the HTML `name="..."` attribute.
   `label: String`, _required_. The label to display above the input that describes the input.
   `system_arguments: Hash`. See below.
1. `text_area`

### Running the Lookbook app

Requirements:

1. Ruby v3.0
1. Node v16
1. Yarn (`npm install yarn`)

To run the application:

1. Change into the lookbook directory.
1. Run `bundle install` followed by `yarn install`.
1. Run bin/dev
1. Visit http://localhost:3000 in your browser
1. Profit
