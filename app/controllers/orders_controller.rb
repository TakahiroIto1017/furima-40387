class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_index
  before_action :sold_index

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

  def owner_index
    redirect_to root_path if current_user.id == Item.find(params[:item_id]).user.id
  end

  def sold_index
    redirect_to root_path if Item.find(params[:item_id]).order.present?
  end
end