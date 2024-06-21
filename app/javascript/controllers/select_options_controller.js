import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["branchSelect", "unitSelect"];

  connect() {
    this.triggerChangeEvent();
  }

  triggerChangeEvent() {
    const event = new Event("change", { bubbles: true });
    this.branchSelectTarget.dispatchEvent(event);
  }

  async fetchStudyUnits(event) {
    const studyBranchId = this.branchSelectTarget.value;

    try {
      const data = await this.fetchUnitsFromServer(studyBranchId);
      this.updateStudyUnits(data);
    } catch (error) {
      console.error("Error fetching study units:", error);
    }
  }

  async fetchUnitsFromServer(studyBranchId) {
    const response = await fetch("/study_unit_options", {
      method: "POST",
      cache: "no-cache",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector("meta[name='csrf-token']")
          .getAttribute("content"),
      },
      body: JSON.stringify({ study_branch_id: studyBranchId }),
    });

    if (!response.ok) {
      throw new Error(`Network response was not ok: ${response.statusText}`);
    }

    return await response.json();
  }

  updateStudyUnits(units) {
    const studyUnitSelect = this.unitSelectTarget;
    const id = 0
    const name = 1

    studyUnitSelect.innerHTML = units
      .map((unit) => `<option value="${unit[id]}">${unit[name]}</option>`)
      .join("");
  }
}
