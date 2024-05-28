import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["studyUnitSelect"]

  async fetchStudyUnits(event) {
    debugger
    const studyBranchId = event.target.value;
    const response = await fetch(`/obtener_study_units?study_branch_id=${studyBranchId}`);
    const studyUnits = await response.json();

    this.studyUnitSelectTarget.innerHTML = studyUnits.map(unit => `<option value="${unit.id}">${unit.name}</option>`).join('');
  }
}