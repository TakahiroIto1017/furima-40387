class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end