class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    # Strong Parametersを使用し、安全にパラメータを取得
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_cost_burden_id,
                                 :prefecture_id, :shipping_duration_id, :price)
  end
end
