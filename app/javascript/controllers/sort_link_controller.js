import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sort-link"
export default class extends Controller {
  static targets = ["forgetful", "latest"];

  toggle(event) {
    if (event.currentTarget.classList.contains("text-gray-400")) {
      this.forgetfulTarget.classList.add("text-gray-400");
      this.latestTarget.classList.add("text-gray-400");
      event.currentTarget.classList.remove("text-gray-400");
    }
  }
}
