Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :orders, only: [:index, :create]
  end
  root 'items#index'
end
