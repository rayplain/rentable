import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = { id: Number, redirect: Boolean };

    delete(event) {
        event.preventDefault();
        if (confirm("Are you sure you want to delete this property?")) {
            fetch(`/properties/${this.idValue}`, {
                method: "DELETE",
                headers: {
                    "X-CSRF-Token": document.querySelector("[name=csrf-token]").content,
                    "Accept": "application/json"
                }
            })
                .then(response => {
                    if (response.ok) {
                        if (this.redirectValue) {
                            window.location.href = "/properties";
                        }
                        else{
                            this.element.remove();
                        }
                    } else {
                        return response.json().then(data => {
                            alert("Error: " + data.message);
                        });
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("An error occurred while trying to delete the property.");
                });
        }
    }
}