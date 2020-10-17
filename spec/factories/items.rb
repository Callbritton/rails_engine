FactoryBot.define do
  factory :item do
    name { Faker::Movies::Lebowski.character }
    description { Faker::Movies::Lebowski.quote }
    unit_price { 1.5 }
    merchant { nil }
  end
end
