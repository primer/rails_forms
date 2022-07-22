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
   | show_label | Boolean | false | Whether or not to visually show the label text. If `false`, the label will be hidden visually but still announced by screen readers. |
   | trailing_label | String | false | If provided, renders a label to the right of the text input. |
   | size | Symbol | false | One of: `:small`, `:medium`, or `:large`. Default: `:medium`. |
   | show_clear_button | Boolean | false | If `true`, includes a clear button that can be used to clear the contents of the input. Default: `false`. |
   | clear_button_id | String | false | The HTML `id` attribute of the clear button. |
   | inset | Boolean | false | If `true`, renders in an inset state. Default: `false`. |
   | monospace | Boolean | false | If `true`, uses a monospace font for the text input. Default: `false`. |
   | leading_visual | Hash | false | Renders a leading visual icon before the text field's cursor. The hash will be passed to Primer's [Octicon component](https://primer.style/view-components/components/octicon). |
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

   Radio buttons can contain nested forms. For example:

   ```ruby
   sign_up_form.radio_button_group(name: "channel", label: "How did you hear about us?") do |radio_group|
     radio_group.radio_button("friend", label: "From a friend") do |friend_radio|
       friend_radio.nested_form(class: "some-class") do |builder|
         FriendForm.new(builder)
       end
     end
   end
   ```

   Use the `FormList` class to render multiple nested forms (see below).

1. `hidden`. A hidden input. Results in an HTML `<input type="hidden" />`.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

1. `submit`. A submit button. Results in an HTML `<input type="submit" />`.
   | Arg | Type | Required | Description |
   |-|-|-|-|
   | name | String | true | The name to associate with this input. Appears in the HTML `name="..."` attribute. |
   | label | String | true | The text of the submit button. |
   | \*\*system_arguments | Hash | false | [See below.](#system-arguments) |

   Note that the submit input uses Primer's [`ButtonComponent`](https://primer.style/view-components/components/button) under the hood and therefore treats system arguments a bit differently. See [the documentation](https://primer.style/view-components/system-arguments) for more information.

### System arguments

In addition to the input-specific arguments listed above, all inputs also feature the following additional arguments.

| Arg | Type | Description |
|-|-|-|
| id | String | Overrides the HTML `id` attribute generated by Rails with a custom one. |
| class | Array[String] | A list of CSS classes that will be applied to the input. Combined with the `:classes` argument. |
| classes | Array[String] | A list of CSS classes that will be applied to the input. Combined with the `:class` argument. Exists for compatibility with primer/view_components. |
| caption | String | Caption text to render below the input. |
| disabled | Boolean | If `true`, the text input will not allow keyboard input and renders in a disabled state. Default: `false`. |
| invalid | Boolean | If `true`, renders a red border around the input or otherwise indicates the input is invalid. Default: `false`. Not supported for check boxes, radio buttons, or radio groups. |
| validation_message | String | A validation message to render in red text below the input. If this argument is truthy, `invalid` is implicitly set to `true`. Default: `nil`. Not supported for check boxes, radio buttons, or radio groups. |
| full_width | Boolean | If true, the input will stretch to fill its container. Default: `false`. |
| label_arguments | Hash | System arugments passed to the Rails builder's `#label` method. These arguments will appear as HTML attributes on the `<label>` tag. |
| aria | Hash | Sets `aria-*` attributes on the input. Eg. `aria: { describedby: "foo" }`. |
| data | Hash | Sets `data-*` attributes on the input. Eg. `data: { custom_thing: "hello" }`. |

Under the hood, primer/rails_forms calls methods on a Rails form builder to render inputs on the page. Unless explicitly mentioned above, any arguments passed as `**system_arguments` are ultimately passed to the builder methods. For example, the `text_field` method ultimately calls `builder.text_field(name, **system_arguments)`. See the [Rails `TagHelper` code](https://github.com/rails/rails/blob/914caca2d31bd753f47f9168f2a375921d9e91cc/actionview/lib/action_view/helpers/tag_helper.rb) for details about arguments Rails treats specially.

### Composing Forms

Form objects can be rendered inside other form objects. Consider the following form:

```ruby
class NameForm < ApplicationForm
  form do |name_form|
    name_form.text_field(
      name: :first_name,
      label: "First name"
    )

    name_form.text_field(
      name: :last_name,
      label: "Last name"
    )
  end
end
```

The `NameForm` can be rendered inside another form via the `#fields_for` method:

```ruby
class SignupForm < ApplicationForm
  form do |signup_form|
    signup_form.fields_for(:name_attributes) do |builder|
      NameForm.new(builder)
    end

    signup_form.text_field(
      name: :occupation,
      label: "Occupation"
    )
  end
end
```

The `#fields_for` method calls `#fields_for` on `SignupForm`'s Rails form builder, which is the standard Rails method used to accept nested attributes for an active record object.

To render multiple forms, use the `FormList` class:

```ruby
class SignupForm < ApplicationForm
  form do |signup_form|
    signup_form.fields_for(:name_attributes) do |builder|
      Primer::RailsForms::FormList.new(
        NameForm.new(builder),
        AddressForm.new(builder)
      )
    end

    signup_form.text_field(
      name: :occupation,
      label: "Occupation"
    )
  end
end
```

### Caption Templates

While primer/rails_forms allows including a textual caption below an input, more complicated captions that contain, for example, HTML markup, quickly become unweildy. Complicated captions can be moved into their own template files and will be automatically rendered below the input, just like a textual caption would be.

Caption templates must exist in a directory named after the file the form is defined in, and follow the pattern "<input name>_caption.html.erb". For example, consider the following form:

```ruby
# app/forms/name_form.rb

class NameForm < ApplicationForm
  form do |name_form|
    name_form.text_field(
      name: :first_name,
      label: "First name"
    )

    name_form.text_field(
      name: :last_name,
      label: "Last name"
    )
  end
end
```

Define a caption template for the first name input by creating an ERB file in app/forms/name_form:

```erb
<%# app/forms/name_form/first_name_caption.html.erb %>
<span class="color-fg-danger">Warning! </span>Your name must be awesome.
```

### Rendering after content

Content can be rendered after all the form inputs but before the closing `</form>` tag. Include such content in a file called after_content.html.erb inside the form's directory. Using the `NameForm` example from above:

```erb
<%# app/forms/name_form/after_content.html.erb %>
<span>Some content rendered after all the inputs</span>
```

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
