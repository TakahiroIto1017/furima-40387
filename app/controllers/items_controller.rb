class ItemsController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

end
