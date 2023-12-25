import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search-form"
export default class extends Controller {
  submit(event) {
    if (event.data && event.data == this.eventData) {
      return;
    }

    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      this.eventData = event.data;
      this.element.requestSubmit();
    }, 200);
  }
}
