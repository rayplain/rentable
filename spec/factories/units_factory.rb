FactoryBot.define do
  factory :unit do
    bedroom_count { rand(1..5) }
    bathroom_count { rand(1..3) }
    square_footage { rand(500..2000) }
    rent_price { Faker::Commerce.price(range: 500..5000) }
    association :property
  end
end