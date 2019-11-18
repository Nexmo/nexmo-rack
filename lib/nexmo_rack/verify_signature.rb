# Verify Nexmo Signatures
module Nexmo
  module Rack
    class VerifySignature
      def initialize(app)
        @app = app
      end

      def call(env)
        req = ::Rack::Request.new(env)

        # Duplicate the request params in case nexmo_client.check() modifies them
        params = req.params.dup

        # If there is no `sig` field, ignore this middleware
        return @app.call(env) unless req.params['sig']

        # Otherwise calculate the signature and check that it matches
        if nexmo_client.check(params)
          @app.call(env)
        else
          [403, {}, ['']]
        end
      end

      private

      def nexmo_client
        if ENV['NEXMO_API_SIGNATURE']
          Nexmo::Signature.new(
            ENV['NEXMO_API_SIGNATURE']
          )
        elsif defined?(Rails) && Rails.application.credentials.nexmo
          Nexmo::Signature.new(
            Rails.application.credentials.nexmo[:api_signature]
          )
        else
          raise "No credentials found for Nexmo::Rack::VerifySignature"
        end
      end
    end
  end
end
