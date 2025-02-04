import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggleCalculatorVisibility() {
    this.toggleVisibilityById("calculator");
  }

  toggleDerivativeCalculatorVisibility() {
    this.toggleVisibilityById("derivative_calculator");
  }

  toggleLinearEquationsVisibility() {
    this.toggleVisibilityById("linear_equations");
  }

  toggleVisibilityById(elementId) {
    const element = document.getElementById(elementId);

    if (!element) return;

    element.classList.toggle("hidden");
  }
}