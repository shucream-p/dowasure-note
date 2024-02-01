import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

// Connects to data-controller="tagify"
export default class extends Controller {
  static targets = ["tagInput"];

  connect() {
    const tagify = new Tagify(this.tagInputTarget, {
      dropdown: {
        maxItems: 5,
      },
      originalInputValueFormat: (valuesArr) =>
        valuesArr.map((item) => item.value).join(","),
    });
    let controller;

    tagify.on("input", onInput);

    function onInput(event) {
      const value = event.detail.value;
      tagify.whitelist = null;

      controller && controller.abort();
      controller = new AbortController();

      if (value) {
        fetch(`/api/tags/searches?query=${value}`, {
          signal: controller.signal,
        })
          .then((RES) => RES.json())
          .then(function (newWhitelist) {
            tagify.whitelist = newWhitelist;
            tagify.loading(false).dropdown.show(value);
          });
      }
    }
  }
}
