# Vorm

Simple ORM for Ruby.

**This is a rewrite, and still under development.**


## Installation

Add this line to your application's Gemfile:

    gem 'vorm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vorm


## Usage

Inherit from `Vorm::Model` to get the goodies.

```ruby
class User < Vorm::Model
  # table name
  table 'users'

  # field names
  field 'email'
  field 'phonenumber'

  # or shorthand:
  fields 'name', 'dob'

  # validators
  validate 'email' do |email|
    # field will be passed to block
    # if it isn't empty, so here !email.nil?
    "Email not valid" if email !~ /@/
  end

  # callbacks
  def self.create(*args)
    parent_said = super(args)
    # send email, or whateva
    SignUpMailer.send_welcome(self.id)
    # return what my mama said
    parent_said
  end
end
```


## Contributing

1. Fork it ( https://github.com/vastus/vorm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

