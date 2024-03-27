class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture, :municipality, :house_number, :building_name, :telephone_number

  with_options presence: true do
    validates :user_id, :item_id, :municipality, :house_number
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :telephone_number, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid. Numbers only"}
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postal_code: postal_code, prefecture: prefecture, municipality: municipality, house_number: house_number, building_name: building_name, telephone_number: telephone_number, order_id: order_id)
  end
end