# frozen_string_literal: true

require 'digest/md5'
require 'jwt'
require 'nexmo'
require 'rack'

# Verify Nexmo Signatures
class VerifyNexmoSignature
  def initialize(app)
    @app = app
  end

  def call(_secret, env)
    req = Rack::Request.new(env)
    params = req.env['REQUEST_BODY'].dup
    signature = params.delete('sig')
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
        secret: ENV['NEXMO_API_SIGNATURE']
      )
    elsif Rails.application.credentials.nexmo
      verify = Nexmo::Signature.new(
        signature_secret: Rails.application.credentials.nexmo[:api_signature]
      )
    end
    verify
  end
  
  def digest(params)
    md5 = Digest::MD5.new

    params.sort.each do |k, v|
      md5.update("&#{k}=#{v}")
    end

    md5.update(@secret)

    md5.hexdigest
  end
end
