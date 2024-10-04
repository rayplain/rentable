import { Controller } from "@hotwired/stimulus";
import StimulusReflex from "stimulus_reflex";

export default class extends Controller {
    static targets = ["form", "bedrooms", "cancelButton", "unitsContainer", "bathrooms", "squareFootage", "rentPrice", "crudButtons", "editForm", "details", "editBedrooms", "editBathrooms", "editSquareFootage", "editRentPrice"];

    connect() {
        StimulusReflex.register(this);
        console.log("Unit controller connected");
    }

    showForm(event) {
        event.preventDefault();
        this.formTarget.classList.remove("hidden");
        this.cancelButtonTarget.classList.remove("hidden");
    }
    hideForm(event) {
        event.preventDefault();
        this.formTarget.reset();
        this.formTarget.classList.add("hidden");
        this.cancelButtonTarget.classList.add("hidden");
    }
    toggleUnitList() {
        this.unitsContainerTarget.classList.toggle("hidden");
        this.element.querySelector("button span").textContent = this.unitsContainerTarget.classList.contains("hidden") ? "Show Units" : "Hide Units";
    }
    toggleVisibility(unitId, showEditForm) {
        const details = this.detailsTargets.find(element => element.dataset.unitId === unitId);
        const crudButtons = this.crudButtonsTargets.find(element => element.dataset.unitId === unitId);
        const editForm = this.editFormTargets.find(element => element.dataset.unitId === unitId);

        if (showEditForm) {
            details.classList.add("hidden");
            crudButtons.classList.add("hidden");
            editForm.classList.remove("hidden");
        } else {
            editForm.classList.add("hidden");
            crudButtons.classList.remove("hidden");
            details.classList.remove("hidden");
        }
    }

    create(event) {
        event.preventDefault();

        const propertyId = this.element.dataset.propertyId;

        const unitData = {
            property_id: propertyId,
            bedrooms: this.bedroomsTarget.value,
            bathrooms: this.bathroomsTarget.value,
            square_footage: this.squareFootageTarget.value,
            rent_price: this.rentPriceTarget.value
        };

        this.stimulate("UnitReflex#create", unitData).then(() => {
            this.hideForm(event);
            this.formTarget.reset();
            this.formTarget.classList.add("hidden");
        }).catch((error) => {
            document.getElementById("new_unit_errors").innerText = "Failed to create unit. Please try again.";
            console.error("Unit creation failed:", error);
        });
    }

    edit(event) {
        event.preventDefault();
        const unitId = event.target.closest("[data-unit-id]").dataset.unitId;
        this.toggleVisibility(unitId, true);
    }

    cancelEdit(event) {
        event.preventDefault();
        const unitId = event.target.closest("[data-unit-id]").dataset.unitId;
        this.toggleVisibility(unitId, false);
    }
    update(event) {
        event.preventDefault();
        const unitId = event.target.closest("[data-unit-id]").dataset.unitId;

        const editForm = this.editFormTargets.find(element => element.dataset.unitId === unitId);
        const editBedrooms = this.editBedroomsTargets.find(element => element.dataset.unitId === unitId);
        const editBathrooms = this.editBathroomsTargets.find(element => element.dataset.unitId === unitId);
        const editSquareFootage = this.editSquareFootageTargets.find(element => element.dataset.unitId === unitId);
        const editRentPrice = this.editRentPriceTargets.find(element => element.dataset.unitId === unitId);

        const updateData = {
            unit_id: unitId,
            bedrooms: editBedrooms.value,
            bathrooms: editBathrooms.value,
            square_footage: editSquareFootage.value,
            rent_price: editRentPrice.value
        };

        this.stimulate("UnitReflex#update", updateData).then(() => {
            this.toggleVisibility(unitId, false);
        }).catch((error) => {
            console.error("Unit update failed:", error);
        });
    }

    delete(event) {
        event.preventDefault();

        const unitId = event.target.getAttribute("data-unit-id");
        const propertyId = this.element.dataset.propertyId;

        if (confirm("Are you sure you want to delete this unit?")) {
            this.stimulate("UnitReflex#destroy", { unit_id: unitId, property_id: propertyId }).then(() => {
                event.target.closest('.border-b').remove();
            }).catch((error) => {
                console.error("Unit deletion failed:", error);
            });
        }
    }
}