require 'rails_helper'

RSpec.describe ObtainAuthenticationToken do
  describe '#call' do
    let(:instance) { described_class.new(params) }

    let(:params) do
      {
        'realm'   => realm,
        'service' => service,
        'scope'   => scope
      }
    end

    let(:realm)   { 'https://auth.example.com/token' }
    let(:service) { 'registry.example.com' }
    let(:scope)   { 'repository:hello/world:pull,push' }

    let(:response_body) do
      {
        token: token
      }
    end

    let(:response_headers) do
      {
        'Content-Type' => 'application/json'
      }
    end

    let(:token) { 'returned-token' }

    let!(:stubbed_request) do
      stub_request(:get, realm).with(query: {
        client_id:     'docker-registry-browser',
        offline_token: true,
        scope:         scope,
        service:       service
      }).to_return(body: response_body.to_json, headers: response_headers)
    end

    it 'sends a request to the realm' do
      instance.call

      expect(stubbed_request).to have_been_made
    end

    it 'returns the received token' do
      expect(instance.call).to eq token
    end
  end
end
