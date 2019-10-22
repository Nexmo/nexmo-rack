# frozen_string_literal: true

require 'digest/md5'
require 'jwt'
require 'rack'

# Verify Nexmo Signatures
class VerifyNexmoSignature
  def initialize(app, secret)
    @app = app
    @secret = secret
  end

  def call(_secret, env)
    req = Rack::Request.new(env)
    params = req.env['REQUEST_BODY'].dup
    signature = params.delete('sig')

    if ::JWT::SecurityUtils.secure_compare(signature, digest(params))
      @app.call(env)
    else
      [403, {}, '']
    end
  end

  private

  def digest(params)
    md5 = Digest::MD5.new

    params.sort.each do |k, v|
      md5.update("&#{k}=#{v}")
    end

    md5.update(@secret)

    md5.hexdigest
  end
end
