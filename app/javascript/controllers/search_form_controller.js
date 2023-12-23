import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-form"
export default class extends Controller {
  submit(event) {
    if (event.data !== undefined) {
      clearTimeout(this.timeout);

      this.timeout = setTimeout(() => {
        this.element.requestSubmit();
      }, 200);
    }
  }
}
