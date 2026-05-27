Rails.application.routes.draw do
  root to: "repositories#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "repo/*repo/tag/*tag",    to: "tags#show",         as: :tag,         constraints: { repo: /.+/, tag: /[^\/]+/ }
  get "repo/*repo",             to: "repositories#show", as: :repository,  constraints: { repo: /.+/ }

  get "*repo:*tag",             to: redirect("repo/%{repo}/tag/%{tag}"),   constraints: { repo: /.+/, tag: /[^\/]+/ }
  get "*repo",                  to: redirect("repo/%{repo}"),              constraints: { repo: /.+/ }

  delete "repo/*repo/tag/*tag", to: "tags#destroy",                        constraints: { repo: /.+/, tag: /[^\/]+/ }
end
