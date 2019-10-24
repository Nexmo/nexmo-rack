# Verify Nexmo Signatures
module VerifyNexmoSignature
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      req = ::Rack::Request.new(env)
      params = req.env['REQUEST_BODY'].dup
      verify = nexmo_client

      if verify.check(params)
        @app.call(env)
      else
        [403, {}, '']
      end
    end

    private

    def nexmo_client
      if ENV['NEXMO_API_SIGNATURE']
        verify = Nexmo::Signature.new(
          ENV['NEXMO_API_SIGNATURE']
        )
      elsif defined?(Rails) && Rails.application.credentials.nexmo
        verify = Nexmo::Signature.new(
          Rails.application.credentials.nexmo[:api_signature]
        )
      end
      verify
    end
  end
end