class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_sold, only: [:edit, :update]
  before_action :set_maincategories, only: [:new, :create, :edit, :update]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item_tag = ItemTag.new
  end

  def create
    @item_tag = ItemTag.new(item_tag_params)
    if @item_tag.valid?
      @item_tag.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @category = @item.category
  end

  def edit
    redirect_to action: :index and return if @item.user != current_user

    tag_name = @item.tags.pluck(:tag_name).join(',')
    @item_tag = ItemTag.new(
      id: @item.id,
      name: @item.name,
      product_description: @item.product_description,
      category_id: @item.category_id,
      status_id: @item.status_id,
      cover_delivery_cost_id: @item.cover_delivery_cost_id,
      prefecture_id: @item.prefecture_id,
      delivery_id: @item.delivery_id,
      price: @item.price,
      tag_name: tag_name
    )
  end

  def update
    @item_tag = ItemTag.new(item_tag_params)
    @item_tag.id = @item.id # 更新対象のIDを渡す

    if @item_tag.valid?
      @item_tag.update
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  # フォームオブジェクト用のストロングパラメータ
  def item_tag_params
    params.require(:item_tag).permit(
      :name, :product_description, :category_id, :status_id,
      :cover_delivery_cost_id, :prefecture_id, :delivery_id,
      :price, :image, :tag_name
    ).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :product_description, :category_id, :status_id,
                                 :cover_delivery_cost_id, :prefecture_id, :delivery_id,
                                 :price, :image).merge(user_id: current_user.id)
  end

  def check_owner
    redirect_to root_path if @item.user != current_user
  end

  def check_sold
    redirect_to root_path if @item.order.present?
  end

  def set_maincategories
    @maincategories = Category.where(ancestry: nil)
  end
end
