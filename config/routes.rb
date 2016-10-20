Rails.application.routes.draw do
  resources :pages

  # User authentication
  get "/auth/:provider/callback" =>  "sessions#create"
  get "/auth/login", to: "sessions#login", as: "login"
  get "/auth/logout", to: "sessions#logout", as: "logout"
end
