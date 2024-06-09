import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["number1", "number2", "result"];

  sum() {
    const { num1, num2 } = this.getNumbers();
    this.updateResult(num1 + num2);
  }

  subtract() {
    const { num1, num2 } = this.getNumbers();
    this.updateResult(num1 - num2);
  }

  multiply() {
    const { num1, num2 } = this.getNumbers();
    this.updateResult(num1 * num2);
  }

  divide() {
    const { num1, num2 } = this.getNumbers();
    if (num2 !== 0) {
      this.updateResult(num1 / num2);
    } else {
      this.updateResult("Cannot divide by zero");
    }
  }

  getNumbers() {
    const num1 = parseFloat(this.number1Target.value);
    const num2 = parseFloat(this.number2Target.value);
    return { num1, num2 };
  }

  updateResult(value) {
    this.resultTarget.textContent = value;
  }
}
