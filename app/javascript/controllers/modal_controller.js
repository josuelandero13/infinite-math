import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showModal() {
    const divModal = document.getElementById("myModal")

    if (!divModal.classList.contains("hidden")) {
      divModal.classList.add("hidden")
    } else {
      divModal.classList.remove("hidden");
    }
  }
}
