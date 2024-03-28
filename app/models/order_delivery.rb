class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :telephone_number, :order_id

  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  validates :user_id, :item_id, :municipality, :house_number, presence: true
  validates :telephone_number, presence: true, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid. Only 10 or 11 numbers"}


  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
  end
end