# frozen_string_literal: true

require_relative '../../lib/nexmo_rack'

describe Nexmo::Rack::VerifySignature do
  before do
    ENV['NEXMO_SIGNATURE_SECRET'] = 'secret'
    ENV['NEXMO_SIGNATURE_METHOD'] = 'md5hash'
    ENV.delete('NEXMO_SIGNATURE_REQUIRED')
  end

  let(:app) do
    Rack::Builder.new do
      use Nexmo::Rack::VerifySignature
      run(->(env) { [200, env, "app"] })
    end 
  end

  let(:base_params) do
    {
      'message-timestamp' => '2013-11-21 17:31:42',
      'messageId' => '030000002A264B8B',
      'msisdn' => '14843472194',
      'text' => 'Test',
      'timestamp' => '1461605396',
      'to' => '14849970568',
      'type' => 'text',
    }
  end

  let(:app_valid_params) do
    base_params.merge({
      'sig' => '56859cb8e7ba1da0bb9c8ec0e703feb0'
    })
  end

  # Spaces are URL Encoded in GET requests, which provide a different signature
  let(:app_valid_get_params) do
    base_params.merge({
      'message-timestamp' => '2013-11-21+17:31:42',
      'sig' => '21dc632821a11e6951a08ceaff871022'
    })
  end

  let(:app_invalid_params) do
    base_params.merge({
      'sig' => 'xxxx'
    })
  end

  context 'credential checks' do
    it 'raises if no credentials are found' do
      ENV.delete('NEXMO_SIGNATURE_SECRET')
      expect {
        Rack::MockRequest.new(app).post('/', params: {'sig' => 'some_value'}) 
      }.to raise_error "No signature credentials found for Nexmo::Rack::VerifySignature"
    end

    xit 'raises if no signature method are found' do
      ENV.delete('NEXMO_SIGNATURE_METHOD')
      expect {
        Rack::MockRequest.new(app).post('/', params: {'sig' => 'some_value'}) 
      }.to raise_error "No signature method found for Nexmo::Rack::VerifySignature"
    end
  end

  context 'POST requests' do
    it 'passes requests through to the controller for valid signatures' do
      response = Rack::MockRequest.new(app).post('/', params: app_valid_params)
      expect(response.status).to eq(200)
    end

    it 'returns a 403 HTTP response for invalid signatures' do
      response = Rack::MockRequest.new(app).post('/', params: app_invalid_params)
      expect(response.status).to eq(403)
    end
  end

  context 'GET requests' do
    it 'passes requests through to the controller for valid signatures' do
      response = Rack::MockRequest.new(app).get('/', params: app_valid_get_params)
      expect(response.status).to eq(200)
    end

    it 'returns a 403 HTTP response for invalid signatures' do
      response = Rack::MockRequest.new(app).get('/', params: app_invalid_params)
      expect(response.status).to eq(403)
    end
  end

  context 'GET requests' do
    it 'ignores any requests that do not contain a sig field by default' do
      response = Rack::MockRequest.new(app).post('/', params: {'example' => 'here'})
      expect(response.status).to eq(200)
    end

    it 'validates all requests when signature validation is enforced' do
      ENV['NEXMO_SIGNATURE_REQUIRED'] = 'true'
      response = Rack::MockRequest.new(app).post('/', params: {'example' => 'here'})
      expect(response.status).to eq(403)
    end
  end
end
