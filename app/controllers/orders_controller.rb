class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!

  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      # pay_item # ここでPAY.JPの処理を呼び出すなどの決済処理を行う
      @order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token).merge(
      user_id: current_user.id, item_id: @item.id
    )
  end

  def pay_item
    # PAY.JPの決済処理を実装
  end
end
