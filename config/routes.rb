Rails.application.routes.draw do
  devise_for :users

  # Itemsに関するルートを限定的に設定
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    # 必要に応じてネストされたリソースや追加ルートをここに配置
  end

  root 'items#index'  # ホームページをitemsのindexアクションに設定
end
