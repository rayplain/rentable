class UnitReflex < ApplicationReflex
  def create(params)
    property = Property.find(params["property_id"])

    @unit = property.units.build(
      bedroom_count: params["bedrooms"],
      bathroom_count: params["bathrooms"],
      square_footage: params["square_footage"],
      rent_price: params["rent_price"]
    )

    if @unit.save
      morph "#units-list-#{property.id}", ApplicationController.render(
        partial: "units/unit",
        collection: property.units,
        as: :unit,
        locals: { property: property }
      )
    else
      morph "#new_unit_errors", @unit.errors.full_messages.join(", ")
    end
  end

  def update(params)
    unit = Unit.find(params["unit_id"])

    if unit.update(
      bedroom_count: params["bedrooms"],
      bathroom_count: params["bathrooms"],
      square_footage: params["square_footage"],
      rent_price: params["rent_price"]
    )
      property = unit.property
      morph "#units-list-#{property.id}", ApplicationController.render(
        partial: "units/unit",
        collection: property.units,
        as: :unit,
        locals: { property: property }
      )
    else
      morph "#new_unit_errors", unit.errors.full_messages.join(", ")
    end
  end

  def destroy(params)
    unit = Unit.find(params["unit_id"])

    property = unit.property
    if unit.destroy
      morph "#units-list-#{property.id}", ApplicationController.render(
        partial: "units/unit",
        collection: property.units,
        as: :unit,
        locals: { property: property }
      )
    else
      morph "#new_unit_errors", "Failed to delete unit."
    end
  end
end