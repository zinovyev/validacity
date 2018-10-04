# Validacity

Move validation definitions out of you models and form objects.

## Usage

You can apply multiple sets of validation rules on-fly,
remove any them if not needed and re-validate object against
new rules afterwards.

By the way, the validation errors will be putten to the object
so all your view helpers will be available to display the error list.

This approach will suitable if you need to validate different states
of the same object differently. Say you're using a state machine
and each state has it's own field set and the fields from the other
satates shouldn't be validated at this time.

Or perhaps you just have to many constructions like
`validate :blablabla, presence: true` in your model class and you want to
get rid of it so you can focus on buisiness logic.

You can add a concern to your model so it becomes **validatable**:

```ruby

# app/models/user.rb

class User
  include Validacity::Validatable
  validations :user_personal_data
end

```

Generate new validator:

```bash

$ bundle exec rails g validacity:validation UserPersonalData

```

```ruby

# app/validators/user_personal_data_validator.rb

class UserPersonalDataValidator
  validate :name, presence_of: true
  # ...a ton of different validators
end

```

Now let's try to validate your user object:


```ruby

user = User.new

user.valid? # => false

user.name = "John"

uesr.valid? # => true

```

## Installation

Add this line to your application's Gemfile:

```ruby

gem 'validacity'

```

And then execute:

```bash

$ bundle

```

Now run the validator installation command:

```bash

$ bundle exec rails g validacity:install

```

And the event validator:

```bash

$ bundle exec rails g validacity:validator Event

```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
