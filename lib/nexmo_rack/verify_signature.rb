# Verify Nexmo Signatures
module Nexmo
  module Rack
    class VerifySignature
      def initialize(app)
        @app = app
      end

      def call(env)
        req = ::Rack::Request.new(env)
        if req.post?
          params = req.params.dup 
          verify = nexmo_client
          if verify.check(params)
            @app.call(env)
          else
            [403, {}, ['']]
          end
        else
          @app.call(env)
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
end
