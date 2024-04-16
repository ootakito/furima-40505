Rails.application.routes.draw do
  devise_for :users
  # Deviseのルート
  resources :items, only: [:index]
  # トップページへのルート
  root to: "items#index"
end
