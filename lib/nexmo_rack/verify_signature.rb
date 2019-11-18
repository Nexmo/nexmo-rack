# Verify Nexmo Signatures
module Nexmo
  module Rack
    class VerifySignature
      def initialize(app)
        @app = app
        @nexmo = Nexmo::Client.new(
          signature_secret: signature_secret,
          signature_method: signature_method
        )
      end

      def call(env)
        req = ::Rack::Request.new(env)

        # Duplicate the request params in case nexmo_client.check() modifies them
        params = req.params.dup

        # If there is no `sig` field, ignore this middleware unless we explicitly
        # require it to be present
        unless ENV['NEXMO_SIGNATURE_REQUIRED']
          return @app.call(env) unless req.params['sig']
        end

        # Otherwise calculate the signature and check that it matches
        if req.params['sig'] && @nexmo.signature.check(params)
          @app.call(env)
        else
          [403, {}, ['']]
        end
      end

      private

      def signature_secret
        if ENV['NEXMO_SIGNATURE_SECRET']
          ENV['NEXMO_SIGNATURE_SECRET']
        elsif defined?(Rails) && Rails.application.credentials.nexmo
          Rails.application.credentials.nexmo[:signature_secret]
        else
          raise "No signature credentials found for Nexmo::Rack::VerifySignature"
        end
      end

      def signature_method
        if ENV['NEXMO_SIGNATURE_METHOD']
          ENV['NEXMO_SIGNATURE_METHOD']
        elsif defined?(Rails) && Rails.application.credentials.nexmo
          Rails.application.credentials.nexmo[:signature_method]
        else
          raise "No signature method found for Nexmo::Rack::VerifySignature"
        end
      end

    end
  end
end
