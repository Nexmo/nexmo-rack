# Nexmo Rack Middleware

This repo contains Rack middleware that can be used to help integrate Nexmo in to your Rack-based application. It currently contains the following middleware:

* Verify [Nexmo signatures](https://developer.nexmo.com/concepts/guides/signing-messages).
* Plus more to be added

<!-- -->

* [Installation and Usage](#installation-and-usage)
    * [As a standalone application](#as-a-standalone-application)
    * [Mounted into a Rails application](#mounted-into-a-rails-application)
* [Contributing](#contributing)
* [License](#license)

## Installation and Usage

The verify signature middleware can be used standalone or integrated into a Ruby application. The middleware will return a `403` HTTP status code if the signature is not valid, and will continue the application if it is valid.

### As a standalone application

Install the gem on your system:

``` shell
$ gem install nexmo_rack
```

Then require it from within your `config.ru` Rack configuration:

``` ruby
use Nexmo::Rack::VerifySignature
```

An example [config.ru](examples/config.ru.example) can be found in the examples folder. More information on getting up and running with Rack can be found at the [Rack GitHub repository](https://github.com/rack/rack/wiki/(tutorial)-rackup-howto#with-a-ru-config-file).

### Mounted into a Rails Application

Require it in your `Gemfile`:

```ruby
gem nexmo_rack
```

And then add the middleware to your `config/application.rb` file to initialize it with your application:

```ruby
config.middleware.use Nexmo::Rack::VerifySignature
```

## Contributing
We ❤️ contributions from everyone! [Bug reports](https://github.com/Nexmo/nexmo_rack/issues), [bug fixes](https://github.com/Nexmo/nexmo_rack/pulls) and feedback on the library is always appreciated. Look at the [Contributor Guidelines](https://github.com/Nexmo/nexmo_rack/blob/master/CONTRIBUTING.md) for more information.

## License
This project is under the [MIT LICENSE](https://github.com/Nexmo/nexmo_rack/blob/master/LICENSE).
