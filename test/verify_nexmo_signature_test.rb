# frozen_string_literal: true

require_relative '../lib/verify_nexmo_signature'

describe VerifyNexmoSignature do
  before do
    ENV['NEXMO_API_SIGNATURE'] = 'secret'
  end

  let(:app) { ->(env) { [200, env, "app"] } }
  
  let(:app_valid_params) do
    {
      'HTTP_REFERER' => '',
      'PATH_INFO' => 'foo',
      'QUERY_STRING' => 'bar',
      'REQUEST_PATH' => 'path',
      'REQUEST_URI' => 'uri',
      'REQUEST_BODY' => {
        'message-timestamp' => '2013-11-21 17:31:42',
        'messageId' => '030000002A264B8B',
        'msisdn' => '14843472194',
        'text' => 'Test',
        'timestamp' => '1461605396',
        'to' => '14849970568',
        'type' => 'text',
        'sig' => '56859cb8e7ba1da0bb9c8ec0e703feb0'
      }
    }
  end

  let(:app_invalid_params) do
    {
      'HTTP_REFERER' => '',
      'PATH_INFO' => 'foo',
      'QUERY_STRING' => 'bar',
      'REQUEST_PATH' => 'path',
      'REQUEST_URI' => 'uri',
      'REQUEST_BODY' => {
        'message-timestamp' => '2013-11-21 17:31:42',
        'messageId' => '030000002A264B8B',
        'msisdn' => '14843472194',
        'text' => 'Test',
        'timestamp' => '1461605396',
        'to' => '14849970568',
        'type' => 'text',
        'sig' => 'xxxx'
      }
    }
  end

  let :middleware_valid_sig do
    VerifyNexmoSignature::Middleware.new(app)
  end

  it 'does something' do
    puts middleware_valid_sig.call(app_valid_params)
  end
end
