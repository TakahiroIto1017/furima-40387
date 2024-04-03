class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :others_index, only: [:edit, :destroy]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :sold_index, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def others_index
    return unless current_user.id != Item.find(params[:id]).user.id

    redirect_to root_path
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def sold_index
    redirect_to root_path if Item.find(params[:id]).order.present?
  end
end
