module TokenAuthHelpers
  def configure_token_auth
    allow(Rails.configuration.x).to receive(:token_auth_user).and_return('admin')
    allow(Rails.configuration.x).to receive(:token_auth_password).and_return('badmin')
  end

  def stub_catalog_requests(responses = [empty_catalog_response])
    stub_request(:get, 'http://localhost:5000/v2/_catalog?n=100').to_return(responses)
  end

  def stub_repository_requests(responses = [successful_repository_response])
    stub_request(:get, 'http://localhost:5000/v2/repository/tags/list').to_return(responses)
  end

  def stub_token_auth_requests
    stub_request(:get, 'https://auth.example.com/token?client_id=docker-registry-browser&offline_token=true&scope=catalog:*&service=Docker%20Registry').to_return(
      status:  200,
      headers: { 'Content-Type' => 'application/json' },
      body:    { token: 'the-access-token' }.to_json
    )
  end

  def token_auth_required_response
    {
      status: 401, headers: {
        'www-authenticate' => 'bearer realm="https://auth.example.com/token" service="Docker Registry" scope="catalog:*"'
      }
    }
  end

  def empty_catalog_response
    {
      status:  200,
      headers: { 'Content-Type' => 'application/json' },
      body:    { repositories: []}.to_json
    }
  end

  def successful_catalog_response
    {
      status:  200,
      headers: { 'Content-Type' => 'application/json' },
      body:    { repositories: ['repository']}.to_json
    }
  end

  def successful_repository_response
    {
      status:  200,
      headers: { 'Content-Type' => 'application/json' },
      body:    { tags: ['latest'] }.to_json
    }
  end
end
