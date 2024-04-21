class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # ユーザーがログインしていることを保証

  def index
    @items = Item.all
  end

  def new
    @item = Item.new # 新しいItemインスタンスを作成し、フォーム用に@item変数に割り当てる
  end

  def create
    @item = current_user.items.build(item_params) # ログインユーザーに紐づけて新しい商品を構築
    if @item.save # 商品の情報がバリデーションを通過し、データベースに保存された場合
      redirect_to root_path # トップページにリダイレクト
    else
      render :new # 商品情報がバリデーションを通過しない場合は、newビューを再描画
    end
  end

  private

  def item_params
    # Strong Parametersを使用し、安全にパラメータを取得
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_cost_burden_id,
                                 :prefecture_id, :shipping_duration_id, :price)
  end
end
