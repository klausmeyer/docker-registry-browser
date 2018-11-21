require 'rails_helper'

RSpec.describe 'Repositories' do
  describe 'GET /' do
    context 'with existing http basic auth header' do
      let(:headers) do
        {
          'Authorization' => 'Basic YWRtaW46c2VjcmV0'
        }
      end

      let!(:stub) do
        stub_request(:get, 'http://registry:5000/v2/_catalog?n=100')
          .with(headers: headers)
          .to_return(
            body: '{"repositories":[]}',
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'passes the authentication down to the registry' do
        get '/', headers: headers
        expect(stub).to have_been_requested
      end
    end

    context 'without http basic auth' do
      context 'when the registry throws a http 401' do
        let!(:stub) do
          stub_request(:get, 'http://registry:5000/v2/_catalog?n=100')
            .to_return(
              status: 401,
              headers: { 'WWW-Authenticate' => 'Basic realm="Docker Registry"' }
            )
        end

        it 'requests authentication if the registry asks for it' do
          get '/'

          expect(response).to have_http_status :unauthorized
        end
      end
    end
  end
end
