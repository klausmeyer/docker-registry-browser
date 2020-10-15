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
        stub_request(:get, 'http://localhost:5000/v2/_catalog?n=100')
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
          stub_request(:get, 'http://localhost:5000/v2/_catalog?n=100')
            .to_return(
              status: 401,
              headers: { 'WWW-Authenticate' => www_authenticate }
            )
        end

        context 'with a requested basic authentication' do
          let(:www_authenticate) { 'Basic realm="Docker Registry"' }

          it 'asks the browser for username and password' do
            get '/'

            expect(response).to have_http_status :unauthorized
          end
        end

        context 'with a requested token authentication' do
          let(:www_authenticate) { 'Bearer realm="https://auth.example.com/token",service="registry.example.com",scope="repository:hello/world:pull,push"' }
          let(:service_double)   { instance_double('ObtainAuthenticationToken', call: token) }
          let(:token)            { 'received-token' }

          before do
            allow(ObtainAuthenticationToken).to receive(:new).and_return(service_double)
          end

          context 'when there are token credentials configured' do
            before do
              allow(Rails.configuration.x).to receive(:token_auth_user).and_return('username')
              allow(Rails.configuration.x).to receive(:token_auth_password).and_return('password')
            end

            it 'authenticates against the indicated realm' do
              get '/'

              expect(ObtainAuthenticationToken).to have_received(:new).with({
                'realm'   => 'https://auth.example.com/token',
                'service' => 'registry.example.com',
                'scope'   => 'repository:hello/world:pull,push'
              }, ['username', 'password'])
              expect(service_double).to have_received(:call)
            end

            it 'stores the token in session' do
              get '/'

              expect(session[:registry_auth_token]).to eq token
            end

            it 'reloads the current page' do
              get '/'

              expect(response).to redirect_to '/'
            end
          end

          context 'when there are no token credentials configured' do
            context 'when basic credentials available in the current request' do
              it 'requests those from the browser' do
                get '/'

                expect(response).to have_http_status :unauthorized
              end
            end

            context 'when basic credentials are available' do
              let(:headers) do
                {
                  'Authorization' => 'Basic YWRtaW46c2VjcmV0'
                }
              end

              it 'uses them to request a token' do
                get '/', headers: headers

                expect(ObtainAuthenticationToken).to have_received(:new).with({
                  'realm'   => 'https://auth.example.com/token',
                  'service' => 'registry.example.com',
                  'scope'   => 'repository:hello/world:pull,push'
                }, ['admin', 'secret'])
                expect(service_double).to have_received(:call)
              end
            end
          end
        end
      end
    end
  end
end
