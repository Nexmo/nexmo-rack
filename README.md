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

The verify signature middleware can be used standalone or integrated into a Ruby application. The middleware will return a `403` HTTP status code if the signature is not valid, and will continue the application if it is valid.

### As a standalone application

Install the gem on your system:

``` shell
$ gem install verify_nexmo_signature
```

Then require it from within your `config.ru` Rack configuration:

``` ruby
use VerifyNexmoSignature::Middleware
```

An example [config.ru](examples/config.ru.example) can be found in the examples folder. More information on getting up and running with Rack can be found at the [Rack GitHub repository](https://github.com/rack/rack/wiki/(tutorial)-rackup-howto#with-a-ru-config-file).

### Mounted into a Rails Application

Require it in your `Gemfile`:

```ruby
gem verify_nexmo_signature
```

And then add the middleware to your `config/application.rb` file to initialize it with your application:

```ruby
config.middleware.use VerifyNexmoSignature::Middleware
```

## Contributing
We ❤️ contributions from everyone! [Bug reports](https://github.com/Nexmo/rack-verify-signature-middleware/issues), [bug fixes](https://github.com/Nexmo/rack-verify-signature-middleware/pulls) and feedback on the library is always appreciated. Look at the [Contributor Guidelines](https://github.com/Nexmo/rack-verify-signature-middleware/blob/master/CONTRIBUTING.md) for more information.

## License
This project is under the [MIT LICENSE](https://github.com/Nexmo/rack-verify-signature-middleware/blob/master/LICENSE).
