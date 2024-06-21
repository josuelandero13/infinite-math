import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["myModal"];
  showModal() {
    const divModal = this.myModalTarget

    if (!divModal.classList.contains("hidden")) {
      divModal.classList.add("hidden")
    } else {
      divModal.classList.remove("hidden");

      this.element.dispatchEvent(new CustomEvent("modalShown"));
    }
  }
}
