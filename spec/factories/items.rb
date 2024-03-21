FactoryBot.define do
  factory :item do
    title            { Faker::Food.dish }
    description      { Faker::Food.description }
    category_id      { Faker::Number.between(from: 1, to: 10) }
    condition_id     { Faker::Number.between(from: 1, to: 6) }
    shipping_cost_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id    { Faker::Number.between(from: 1, to: 47) }
    shipping_date_id { Faker::Number.between(from: 1, to: 3) }
    price            { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
  end
end
