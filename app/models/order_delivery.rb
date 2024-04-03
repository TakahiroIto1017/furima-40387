class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name,
                :telephone_number, :order_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :municipality
    validates :house_number
    validates :telephone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Only 10 or 11 numbers' }
    validates :token, presence: { message: "can't be blank. Enter your credit card information" }
  end

  def save
    order = Order.create(user_id:, item_id:)
    Delivery.create(postal_code:, prefecture_id:, municipality:,
                    house_number:, building_name:, telephone_number:, order_id: order.id)
  end
end
