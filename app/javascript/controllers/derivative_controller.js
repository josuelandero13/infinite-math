import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["expression", "result"];

  async calculateDerivative(event) {
    event.preventDefault();

    const expression = event.target.querySelector("#expression").value;

    const response = await fetch("/calculate_derivative", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector(
          'meta[name="csrf-token"]'
        ).content,
      },
      body: JSON.stringify({ expression: expression }),
    });

    const data = await response.json();

    if (response.ok) {
      document.getElementById(
        "result"
      ).innerText = `Derivada: ${data.derivative}`;
    } else {
      document.getElementById(
        "result"
      ).innerText = `Error: ${data.error}`;
    }
  }
}
