# Verify Nexmo Signatures Rack Middleware
Integrate this middleware into your application to verify [Nexmo signatures](https://developer.nexmo.com/concepts/guides/signing-messages).

* [Dependencies](#requirements)
* [Installation and Usage](#installation-and-usage)
    * [As a standalone application](#as-a-standalone-application)
    * [Mounted into a Rails application](#mounted-into-a-rails-application)
* [Contributing](#contributing)
* [License](#license)

## Dependencies

This middleware utilizes the following dependencies:

* [JWT](https://github.com/jwt/ruby-jwt)
* [Digest](https://github.com/ruby/digest)

## Installation and Usage

The verify signature middleware can be used standalone or integrated into a Ruby application. The middleware will return `true` if the signature is valid, or `false` if it is not.

### As a standalone application

Install the gem on your system:

``` shell
$ gem install verify_nexmo_signature
```

Require it from within your application, instantiate an instance and use it:

``` ruby
require 'verify_nexmo_signature'

verify = VerifyNexmoSignature.new('secret')

response = verify.call({'a' => '1', 'b' => '2', 'timestamp' => '1461605396', 'sig' => '6af838ef94998832dbfc29020b564830'})

puts response.inspect
```

### Mounted into a Rails Application

Require it in your `Gemfile`:

```ruby
gem verify_nexmo_signature
```

And then add the middleware to your `config/application.rb` file to initialize it with your application:

```ruby
config.middleware.use VerifyNexmoSignature
```

Then from within your application you can instantiate and utilize it as follows, passing in the signature secret parameter:

```ruby
verify = VerifyNexmoSignature.new(@secret)

verify.call({'a' => '1', 'b' => '2', 'timestamp' => '1461605396', 'sig' => '6af838ef94998832dbfc29020b564830'})
```

## Contributing
We ❤️ contributions from everyone! [Bug reports](https://github.com/Nexmo/rack-verify-signature-middleware/issues), [bug fixes](https://github.com/Nexmo/rack-verify-signature-middleware/pulls) and feedback on the library is always appreciated. Look at the [Contributor Guidelines](https://github.com/Nexmo/rack-verify-signature-middleware/blob/master/CONTRIBUTING.md) for more information.

## License
This project is under the [MIT LICENSE](https://github.com/Nexmo/rack-verify-signature-middleware/blob/master/LICENSE).
