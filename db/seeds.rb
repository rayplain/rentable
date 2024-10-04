# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Clear existing data
Unit.destroy_all
Property.destroy_all

100.times do
  property = Property.create!(
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state
  )

  rand(1..10).times do
    Unit.create!(
      property: property,
      bedroom_count: rand(1..5),
      bathroom_count: rand(1..3),
      square_footage: rand(500..2000),
      rent_price: Faker::Commerce.price(range: 500..5000)
    )
  end
end

puts "Created #{Property.count} properties with #{Unit.count} units."