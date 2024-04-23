Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    # 必要に応じてネストされたリソースや追加ルートをここに配置
  end

  root 'items#index'  # ホームページをitemsのindexアクションに設定
end
