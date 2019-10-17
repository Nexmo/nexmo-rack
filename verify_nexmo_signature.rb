# frozen_string_literal: true

require 'digest/md5'
require 'jwt'

class VerifyNexmoSignature
  def initialize(secret)
    @secret = secret
  end

  def call(secret)
    params = secret.dup

    signature = params.delete('sig')

    ::JWT::SecurityUtils.secure_compare(signature, digest(params))
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
