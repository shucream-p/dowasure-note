import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="text"
export default class extends Controller {
  static targets = ["container"];

  toggleTruncate() {
    const container = this.containerTarget;

    if (
      container.offsetWidth < container.scrollWidth ||
      !container.classList.contains("truncate")
    ) {
      container.classList.toggle("truncate");
    }
  }
}
