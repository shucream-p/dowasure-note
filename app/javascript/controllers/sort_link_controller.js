import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sort-link"
export default class extends Controller {
  static targets = ["forgetful", "latest"];

  toggleHidden(event) {
    const sortLink = document.getElementById("js-sort-link");

    if (event.currentTarget.value != "") {
      sortLink.classList.add("hidden");
    } else {
      sortLink.classList.remove("hidden");
    }
  }

  toggle(event) {
    const gray = "text-gray-400";

    if (event.currentTarget.classList.contains(gray)) {
      this.forgetfulTarget.classList.toggle(gray);
      this.latestTarget.classList.toggle(gray);
    }
  }
}
