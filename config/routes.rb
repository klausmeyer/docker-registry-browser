Rails.application.routes.draw do
  root to: 'repositories#index'

  get 'repo/*repo/tag/*tag', to: 'tags#show',         as: :tag, constraints: { tag: /[^\/]+/ }
  get 'repo/*repo',          to: 'repositories#show', as: :repository

  delete 'repo/*repo/tag/*tag', to: 'tags#destroy', constraints: { tag: /[^\/]+/ }

  get :ping, to: Proc.new { [200, {'Content-Type' => 'text/plain'}, ['pong']] }
end
