FactoryBot.define do
  factory :item do
    name { Faker::Movies::Lebowski.character }
    description { Faker::Movies::Lebowski.quote }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
