class OrdersController < ApplicationController

  def index
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postal_code, :prefecture, :municipality, :house_number, :building_name, :telephone_number, :order_id).merge(user_id: current_user.id, item_id: item_id)
  end
end