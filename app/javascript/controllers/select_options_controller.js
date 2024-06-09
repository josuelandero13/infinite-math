import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  async fetchStudyUnits(event) {
    const studyBranchId = event.target.value;

    try {
      const data = await this.fetchUnitsFromServer(studyBranchId);
      this.updateStudyUnits(data);
    } catch (error) {
      console.error("Error fetching study units:", error);
    }
  }

  async fetchUnitsFromServer(studyBranchId) {
    const response = await fetch("/study_units", {
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
    const studyUnitSelect = document.getElementById("study_unit_select");
    const id = 0
    const name = 1

    studyUnitSelect.innerHTML = units
      .map((unit) => `<option value="${unit[id]}">${unit[name]}</option>`)
      .join("");
  }
}
