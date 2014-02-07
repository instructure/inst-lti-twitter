InstLtiTwitter::Engine.routes.draw do
  root to: "lti#index"
  match "/" => "lti#index", via: [:get, :post]
  get "/api/tweets" => "api#tweets"
  post "/api/embed" => "api#embed"
  get "health_check" => "api#health_check"
  get "config(.xml)" => "api#xml_config"
  get "test/backdoor" => "test#backdoor"
end
