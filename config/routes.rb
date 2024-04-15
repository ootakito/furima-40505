Rails.application.routes.draw do
  devise_for :users
  # Deviseのルート

  # トップページへのルート
  root to: "items#index"
end
