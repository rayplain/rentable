require 'rails_helper'

RSpec.describe 'Property Index Page', type: :system do
  let!(:property) { create(:property) }
  let!(:unit) { create(:unit, property: property) }

  before do
    driven_by(:selenium_chrome_headless)
  end

  describe 'Property Page' do
    it 'shows a list of properties and allows searching' do
      visit properties_path
      expect(page).to have_content(property.address)

      fill_in 'Search properties', with: property.address
      click_button 'Search'
      expect(page).to have_content(property.address)
    end
  end

  describe 'Unit Management' do
    before { visit property_path(property) }

    it 'displays a list of units for the property' do
      expect(page).to have_content("Units")
      expect(page).to have_content(unit.bedroom_count)
      expect(page).to have_content(unit.bathroom_count)
    end

    it 'toggles the visibility of the unit list on properties page' do
      visit properties_path

      within("[data-property-id='#{property.id}']") do
        expect(page).not_to have_selector("[data-unit-target='unitsContainer']", visible: true)

        find("button[data-action='click->unit#toggleUnitList']").click

        expect(page).to have_selector("[data-unit-target='unitsContainer']", visible: true)

        find("button[data-action='click->unit#toggleUnitList']").click

        expect(page).not_to have_selector("[data-unit-target='unitsContainer']", visible: true)
      end
    end

    it 'creates a new unit' do
      click_button 'Add Unit'
      fill_in 'Bedrooms', with: 2
      fill_in 'Bathrooms', with: 1
      fill_in 'Square Footage', with: 900
      fill_in 'Rent Price', with: 1200
      click_button 'Save'

      expect(page).to have_content('2')
      expect(page).to have_content('900')
      expect(page).to have_content('$1,200.00')
    end

    it 'edits an existing unit' do
      within("#units-list-#{property.id}") do
        click_link 'Edit'
      end

      fill_in 'Bedrooms', with: 3
      fill_in 'Bathrooms', with: 2
      fill_in 'Square Footage', with: 1200
      fill_in 'Rent Price', with: 1500
      click_button 'Save'

      expect(page).to have_content('3')
      expect(page).to have_content('1200')
      expect(page).to have_content('$1,500.00')
    end

    it 'deletes a unit' do
      within("#units-list-#{property.id}") do
        click_button 'Delete'
      end

      accept_alert 'Are you sure you want to delete this unit?'

      expect(page).not_to have_content(unit.id)
    end
  end
end