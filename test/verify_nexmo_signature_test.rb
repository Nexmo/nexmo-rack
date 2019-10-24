# frozen_string_literal: true

require_relative '../lib/verify_nexmo_signature'

describe VerifyNexmoSignature do
  before do
    ENV['NEXMO_API_SIGNATURE'] = 'secret'
  end

  let(:app) do
    Rack::Builder.new do
      use VerifyNexmoSignature::Middleware
      run(->(env) { [200, env, "app"] })
    end 
  end  

  let(:app_valid_params) do
    {
      'message-timestamp' => '2013-11-21 17:31:42',
      'messageId' => '030000002A264B8B',
      'msisdn' => '14843472194',
      'text' => 'Test',
      'timestamp' => '1461605396',
      'to' => '14849970568',
      'type' => 'text',
      'sig' => '56859cb8e7ba1da0bb9c8ec0e703feb0'
    }
  end

  let(:app_invalid_params) do
    {
      'message-timestamp' => '2013-11-21 17:31:42',
      'messageId' => '030000002A264B8B',
      'msisdn' => '14843472194',
      'text' => 'Test',
      'timestamp' => '1461605396',
      'to' => '14849970568',
      'type' => 'text',
      'sig' => 'xxxx'
    }
  end

  let :middleware do
    VerifyNexmoSignature::Middleware.new(app)
  end

  it 'returns a 200 HTTP response code if it is called directly and not a POST request' do
    response = middleware.call(app_invalid_params)
    expect(response[0]).to eq(200)
  end

  it 'returns a 200 HTTP response for a POST request with a valid verification' do
    response = Rack::MockRequest.new(app).post('/', params: app_valid_params)

    expect(response.status).to eq(200)
  end

  it 'returns a 403 HTTP response for a POST request with an invalid verification' do
    response = Rack::MockRequest.new(app).post('/', params: app_invalid_params)
    expect(response.status).to eq(403)
  end
end
