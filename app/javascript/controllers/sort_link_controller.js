import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sort-link"
export default class extends Controller {
  static targets = ["forgetful", "latest"];

  toggle(event) {
    const gray = "text-gray-400";

    if (event.currentTarget.classList.contains(gray)) {
      this.forgetfulTarget.classList.toggle(gray);
      this.latestTarget.classList.toggle(gray);
    }
  }
}
