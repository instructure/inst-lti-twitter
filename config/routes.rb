InstLtiTwitter::Engine.routes.draw do
  root to: "lti#index"
  match "/" => "lti#index", via: [:get, :post]
  get "/api/tweets" => "api#tweets"
  post "/api/embed" => "api#embed"
end
