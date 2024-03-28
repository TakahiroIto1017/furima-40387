FactoryBot.define do
  factory :order_delivery do
    postal_code      { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}"  }
    prefecture_id    { Faker::Number.between(from: 1, to: 47) }
    municipality     { Faker::Address.city }
    house_number     { "#{Faker::Number.number(digits: 1)}-#{Faker::Number.number(digits: 1)}-#{Faker::Number.between(from: 1, to: 20)}" }
    building_name    { Faker::Restaurant.name }
    telephone_number { Faker::Number.between(from: 1000000000, to: 99999999999) }
  end
end
