# frozen_string_literal: true

require_relative '../lib/verify_nexmo_signature'

describe VerifyNexmoSignature do
  before do
    ENV['NEXMO_API_SIGNATURE'] = 'secret'
  end

  let(:app_valid_sig) do
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
        'sig' => '6af838ef94998832dbfc29020b564830'
      }
    }
  end

  let(:app_invalid_sig) do
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

  let(:secret) do
    'secret'
  end

  let :middleware_valid_sig do
    VerifyNexmoSignature.new(app_valid_sig)
  end

  it 'does something' do
    puts middleware_valid_sig.call(secret, app_valid_sig)
  end
end
