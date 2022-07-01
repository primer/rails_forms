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

1. `text_field`. A single-line text field. Results in an HTML `<input type="text" />`.

   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The label to display above the input that describes the input. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

1. `text_area`. A multi-line text field. Results in an HTML `<textarea></textarea>`.

   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The label to display above the input that describes the input. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

1. `select_list`. A dropdown list. Results in an HTML `<select></select>`.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The label to display above the input that describes the input. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

   The `select_list` method accepts a block that yields a `SelectInput` object. This object responds to the `option` method that can be used to add items to the select list. The `option` method accepts the following arguments:

   | Arg | Type | Required | Description |
   |-|-|-|-|
   | label | String | true | The visible text the user will see. |
   | value | String | true | The value submitted to the server when the form is submitted. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

   Example:

   ```ruby
   sign_up_form.select_list(name: "foo", label: "Choose your foo") do |select_list|
     select_list.option("Foo 1", "foo-1")
     select_list.option("Foo 2", "foo-2")
   end
   ```

1. `checkbox`. A checkbox. Results in an HTML `<input type="checkbox" />`.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The label to display above the input that describes the input. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

1. `radio_button_group`. A set of radio buttons. Results in multiple HTML `<input type="radio" />` elements.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The label to display above the group of buttons that describes the group as a whole. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

   The `radio_button_group` method accepts a block that yields a `RadioButtonGroupInput` object. This object responds to the `radio_button` method that can be used to add individual radio buttions to the group. The `radio_button` method accepts the following arguments:

   | Arg | Type | Required | Description |
   |-|-|-|-|
   | label | String | true | The label to display to the right of the button. |
   | value | String | true | The value submitted to the server when the form is submitted. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

   Example:

   ```ruby
   sign_up_form.radio_button_group(name: "channel", label: "How did you hear about us?") do |radio_group|
     radio_group.radio_button(value: "online", label: "Online ad")
     radio_group.radio_button(value: "radio", label: "Radio ad")
     radio_group.radio_button(value: "friend", label: "From a friend")
   end
   ```

1. `hidden`. A hidden input. Results in an HTML `<input type="hidden" />`.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

### System arguments

Under the hood, rails_forms calls methods on a Rails form builder to render inputs on the page. Any arguments passed in the hash of `**system_arguments` keyword args are ultimately passed to the builder methods. For example, the `text_field` method above ultimately calls `builder.text_field(name, **system_arguments)`. See the [Rails `TagHelper` code](https://github.com/rails/rails/blob/914caca2d31bd753f47f9168f2a375921d9e91cc/actionview/lib/action_view/helpers/tag_helper.rb) for details around acceptable arguments.

### Rendering forms

As with view components, forms are rendered using the familiar `render` method. Instantiating a form requires you pass it a builder object, which are created by Rails' `form_with` and `form_for` helpers.

```erb
<%= form_with(model: SignUp.new) do |f| %>
  <%= render(SignUpForm.new(f)) %>
<% end %>
```

## Known Issues

1. The default Rails form builder will sometimes not attach IDs to form inputs, which also results in the omission of the `for=` attribute on the accompanying label. To fix, pass `skip_default_ids: false` to `form_with` and friends:
    ```erb
    <%= form_with(model: foo, skip_default_ids: false) do |f| %>
      <%= render(MyForm.new(f)) %>
    <% end >
    ```

## Releasing

The primer/rails_forms gem will very likely never be published to RubyGems. We plan on eventually merging it into primer/view_components. To use the gem in dotcom, run the `bin/vendor-gem` script:

```bash
SOURCE_DATE_EPOCH=0 bin/vendor-gem -r <git commit SHA> -n primer_rails_forms https://github.com/primer/rails_forms.git
```

**NOTE**: The `SOURCE_DATE_EPOCH=0` environment variable is important. It causes Rubygems to use a value of zero as the current timestamp in the gzip header of the resulting .gem file. If omitted, the .gem file will appear to have changed even though none of the files inside it have changed. This is inconvenient because it can cause unexpected merge conflicts and prevent shipping two branches that depend on the same version of primer_rails_forms.

If you're using primer/rails_forms outside of dotcom, add it directly to your Gemfile.

```ruby
gem "primer_rails_forms", github: "primer/rails_forms"
```

## Running the Lookbook app

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

### Codespaces

This repo includes the necessary configuration to enable developing locally and running the Lookbook app in a codespace. It also includes a local checkout of [primer/css](https://github.com/primer/css). Changes to the local copy of primer/css are immediately reflected in Lookbook.

If you're using Visual Studio Code, open .vscode/rails-forms-workspace.code-workspace and click the "Open Workspace" button. You should see two folders in the explorer, rails_forms and @primer/css.
