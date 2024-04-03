class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :owner_index
  before_action :sold_index
  before_action :item_find

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def owner_index
    redirect_to root_path if current_user.id == Item.find(params[:item_id]).user.id
  end

  def sold_index
    redirect_to root_path if Item.find(params[:item_id]).order.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(amount: @item.price, card: order_params[:token], currency: 'jpy')
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
