Rails.application.routes.draw do
  # Deviseのルート
  devise_for :users

  # トップページへのルート
  root to: "items#index"
end
