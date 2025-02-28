class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    Order.create(order_params)
  end

  private

  def order_params
    params.require(:order).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
