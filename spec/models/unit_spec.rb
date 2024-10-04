require 'rails_helper'

RSpec.describe Unit, type: :model do
  it 'is valid with valid attributes' do
    unit = FactoryBot.build(:unit)
    expect(unit).to be_valid
  end

  it 'is not valid without a bedroom_count' do
    unit = FactoryBot.build(:unit, bedroom_count: nil)
    expect(unit).to_not be_valid
  end

  it 'is not valid without a bathroom_count' do
    unit = FactoryBot.build(:unit, bathroom_count: nil)
    expect(unit).to_not be_valid
  end

  it 'is not valid without a square_footage' do
    unit = FactoryBot.build(:unit, square_footage: nil)
    expect(unit).to_not be_valid
  end

  it 'is not valid without a rent_price' do
    unit = FactoryBot.build(:unit, rent_price: nil)
    expect(unit).to_not be_valid
  end

  it 'is not valid without a property' do
    unit = FactoryBot.build(:unit, property: nil)
    expect(unit).to_not be_valid
  end
end