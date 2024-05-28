import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["number1", "number2", "result"];

  sum() {
    const num1 = parseFloat(this.number1Target.value);
    const num2 = parseFloat(this.number2Target.value);
    this.resultTarget.textContent = num1 + num2;
  }

  subtract() {
    const num1 = parseFloat(this.number1Target.value);
    const num2 = parseFloat(this.number2Target.value);
    this.resultTarget.textContent = num1 - num2;
  }

  multiply() {
    const num1 = parseFloat(this.number1Target.value);
    const num2 = parseFloat(this.number2Target.value);
    this.resultTarget.textContent = num1 * num2;
  }

  divide() {
    const num1 = parseFloat(this.number1Target.value);
    const num2 = parseFloat(this.number2Target.value);
    if (num2 !== 0) {
      this.resultTarget.textContent = num1 / num2;
    } else {
      this.resultTarget.textContent = "Cannot divide by zero";
    }
  }
}
