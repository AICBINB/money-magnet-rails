import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-hidden"
export default class extends Controller {
  static targets = [ "id", "password" ]

  showPasswordFields(event) {
    event.preventDefault

    this.passwordTargets.forEach(passwordTarget => {
      passwordTarget.classList.remove("hidden");
    });

    this.idTargets.forEach(idTarget => {
      idTarget.classList.add("hidden");
    });
  }

  showIdFields(event) {
    console.log("HERE")
    event.preventDefault

    this.passwordTargets.forEach(passwordTarget => {
      passwordTarget.classList.add("hidden");
    });

    this.idTargets.forEach(idTarget => {
      idTarget.classList.remove("hidden");
    });
  }
}
