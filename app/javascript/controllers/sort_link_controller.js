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

  toggleTextColor(event) {
    const classNames = ["text-gray-400", "text-white", "bg-indigo-500"];

    if (event.currentTarget.classList.contains("text-gray-400")) {
      classNames.forEach((className) => {
        this.forgetfulTarget.classList.toggle(className);
        this.latestTarget.classList.toggle(className);
      });
    }
  }
}
