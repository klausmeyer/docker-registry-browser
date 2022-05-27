Rails.application.routes.draw do
  root to: "repositories#index"

  get :ping, to: ->(env) { ["200", {"Content-Type" => "text/plain"}, ["pong"]] }

  get "repo/*repo/tag/*tag",    to: "tags#show",         as: :tag,         constraints: {repo: /.+/, tag: /[^\/]+/}
  get "repo/*repo",             to: "repositories#show", as: :repository,  constraints: {repo: /.+/}

  get "*repo:*tag",             to: redirect("repo/%{repo}/tag/%{tag}"),   constraints: {repo: /.+/, tag: /[^\/]+/}
  get "*repo",                  to: redirect("repo/%{repo}"),              constraints: {repo: /.+/}

  delete "repo/*repo/tag/*tag", to: "tags#destroy",                        constraints: {repo: /.+/, tag: /[^\/]+/}
end
