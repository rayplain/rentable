require 'rails_helper'

RSpec.describe Property, type: :model do
  it 'is valid with valid attributes' do
    property = FactoryBot.build(:property)
    expect(property).to be_valid
  end

  it 'is not valid without an address' do
    property = FactoryBot.build(:property, address: nil)
    expect(property).to_not be_valid
  end

  it 'is not valid without a city' do
    property = FactoryBot.build(:property, city: nil)
    expect(property).to_not be_valid
  end

  it 'is not valid without a state' do
    property = FactoryBot.build(:property, state: nil)
    expect(property).to_not be_valid
  end
end