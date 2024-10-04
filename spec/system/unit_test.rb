require 'rails_helper'

RSpec.describe 'Unit management', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:property) { FactoryBot.create(:property) }
  let!(:unit) { FactoryBot.create(:unit, property: property) }

  it 'creates a new unit' do
    visit new_property_unit_path(property)

    fill_in 'Bedrooms', with: 2
    fill_in 'Bathrooms', with: 1
    fill_in 'Square footage', with: 1000
    fill_in 'Rent price', with: 1500

    click_button 'Create Unit'

    expect(page).to have_content('Unit was successfully created.')
    expect(property.units.count).to eq(2)
  end

  it 'updates an existing unit' do
    visit edit_property_unit_path(property, unit)

    fill_in 'Bedrooms', with: 3
    fill_in 'Bathrooms', with: 2
    fill_in 'Square footage', with: 1500
    fill_in 'Rent price', with: 2000

    click_button 'Update Unit'

    expect(page).to have_content('Unit was successfully updated.')
    unit.reload
    expect(unit.bedroom_count).to eq(3)
    expect(unit.bathroom_count).to eq(2)
    expect(unit.square_footage).to eq(1500)
    expect(unit.rent_price).to eq(2000)
  end

  it 'destroys a unit' do
    visit property_units_path(property)

    click_link 'Destroy', href: property_unit_path(property, unit)
    page.accept_alert 'Are you sure?'

    expect(page).to have_content('Unit was successfully destroyed.')
    expect(property.units.count).to eq(0)
  end
end