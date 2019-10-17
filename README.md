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

Clone the repository:

``` shell
$ git clone git@github.com:Nexmo/rack-verify-signature-middleware.git
```

From within IRB, for example, you can run it as follows:
``` ruby
irb> require './verify_nexmo_signature'
=> true
irb> verify = VerifyNexmoSignature.new('secret')
=> #<VerifyNexmoSignature:0x00007f9e0d84c030 @secret="secret">
irb> verify.call({'a' => '1', 'b' => '2', 'timestamp' => '1461605396', 'sig' => '6af838ef94998832dbfc29020b564830'})
=> true
irb> verify.call({'a' => '1', 'b' => '2', 'timestamp' => '1461605396', 'sig' => 'xxxx'})
=> false
```

### Mounted into a Rails Application

Clone the repository:

``` shell
$ git clone git@github.com:Nexmo/rack-verify-signature-middleware.git
```

Copy `verify_nexmo_signature.rb` from the cloned folder into the `app/middleware` folder of your Rails application.

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
