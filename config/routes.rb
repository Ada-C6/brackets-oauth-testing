Rails.application.routes.draw do
  root "sessions#login"
  resources :pages

  # User authentication
  get "/auth/:provider/callback" =>  "sessions#create"
  get "/auth/login", to: "sessions#login", as: "login"
  delete "/auth/logout", to: "sessions#logout", as: "logout"
end
