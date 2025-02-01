class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :product_description, :category_id, :status_id,
                                 :cover_delivery_cost_id, :prefecture_id, :delivery_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
