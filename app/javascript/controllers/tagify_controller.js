import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

// Connects to data-controller="tagify"
export default class extends Controller {
  static targets = ["tagInput"];

  connect() {
    new Tagify(this.tagInputTarget, {
      originalInputValueFormat: (valuesArr) =>
        valuesArr.map((item) => item.value).join(","),
    });
  }
}
