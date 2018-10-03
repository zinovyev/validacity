# Validacity

Move your validation logic out of your models or form objects.

## Usage

You can append validators on-fly and then remove some of them if not needed.

It can be very suitable if you need to validate different states of the same object differently. Say you're using a state machine and each state have it's own field set and the fields from other satates shouldn't be validated at this time.

Or perhaps you just have to many constructions like `validate :blablabla, presence: true` in your model and you want to get rid of it.

All you need is to add a concern to your model:

```ruby

# app/models/user.rb

class User
  include Validacity::Validatable
  validations :user_personal_data
end

```

And generate a validator:

```ruby

# app/validators/user_personal_data_validator.rb

class UserPersonalDataValidator
  validate :name, presence_of: true
  # ...a ton of different validators
end

```

Now call validator with the regular methods like:


```ruby

user.valid?

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
