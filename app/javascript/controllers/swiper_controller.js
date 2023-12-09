import { Controller } from "@hotwired/stimulus";
import Swiper from "swiper";

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    new Swiper(this.containerTarget, {
      slidesPerView: "auto",
      autoHeight: true,
    });
  }
}
