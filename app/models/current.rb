class Current < ActiveSupport::CurrentAttributes
  attribute :http_basic_auth
  attribute :http_token_auth
end
