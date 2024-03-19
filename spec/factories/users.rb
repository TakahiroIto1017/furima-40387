FactoryBot.define do
  factory :user do
    japanese = Gimei.name

    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
    nickname              { Faker::Internet.username }
    first_name            { japanese.first.kanji }
    last_name             { japanese.last.kanji }
    first_name_guide      { japanese.first.katakana }
    last_name_guide       { japanese.last.katakana }
    birthday              { Faker::Date.between(from: '1950-01-01', to: '2020-12-31').strftime('%Y-%m-%d') }
  end
end
