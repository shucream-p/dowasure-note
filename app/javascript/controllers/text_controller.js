import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="text"
export default class extends Controller {
  static targets = ["container"];

  toggle() {
    this.containerTarget.classList.toggle("truncate");
  }
}
