Rails.application.routes.draw do
  root to: 'repositories#index'

  get '*name/tag/*tag', to: 'repositories#tag',  as: :repository_tag
  get '*name',          to: 'repositories#show', as: :repository
end
