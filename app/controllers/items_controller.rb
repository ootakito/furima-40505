class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def edit
    redirect_to root_path unless current_user.id == @item.user_id && !@item.sold?
  end

  def update
    if current_user.id == @item.user_id
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    # Strong Parametersを使用し、安全にパラメータを取得
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :shipping_cost_burden_id,
                                 :prefecture_id, :shipping_duration_id, :price)
  end
end
