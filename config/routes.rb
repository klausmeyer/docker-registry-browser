Rails.application.routes.draw do
  root to: 'repositories#index'

  get 'repo/*repo/tag/*tag', to: 'tags#show',         as: :tag
  get 'repo/*repo',          to: 'repositories#show', as: :repository

  delete 'repo/*repo/tag/*tag', to: 'tags#destroy' if Rails.configuration.x.delete_enabled
end
