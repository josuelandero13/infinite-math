import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["answer"];
  static values = { id: Number };

  async evaluateResponse(event) {
    event.preventDefault();

    const response = await fetch("check_answer_exercise", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({
        answer: this.answerTarget.value,
        exercise_id: this.idValue,
      }),
    });

    const data = await response.json();
    this.showModal(data);
  }

  showModal(data) {
    document.getElementById("response").textContent = data.correct
      ? "Correct!"
      : `Incorrect. The correct answer is ${data.correct_answer}.`;
    document.getElementById("modalResponse").classList.remove("hidden");
  }

  closeModal() {
    document.getElementById("modalResponse").classList.add("hidden");
  }
}
