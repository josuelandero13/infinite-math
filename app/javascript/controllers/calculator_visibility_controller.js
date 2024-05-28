import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggleCalculator() {
    var divCalculator = document.getElementById("calculator");

    if (!divCalculator.classList.contains("hidden")) {
      divCalculator.classList.add("hidden");
    } else {
      divCalculator.classList.remove("hidden");
    }
  }
}
