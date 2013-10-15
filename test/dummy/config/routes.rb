Rails.application.routes.draw do
  mount InstLtiTwitter::Engine => "/twitter"
end
