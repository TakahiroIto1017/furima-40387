FactoryBot.define do
  factory :order_delivery do
    postal_code      { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id    { Faker::Number.between(from: 1, to: 47) }
    municipality     { Faker::Address.city }
    house_number     do
      "#{Faker::Number.number(digits: 1)}-#{Faker::Number.number(digits: 1)}-#{Faker::Number.between(from: 1, to: 20)}"
    end
    building_name    { Faker::Restaurant.name }
    telephone_number { Faker::Number.between(from: 1_000_000_000, to: 99_999_999_999) }
    token            { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end
