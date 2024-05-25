import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showModal() {
    document.getElementById('openModal').addEventListener('click', function() {
      document.getElementById('myModal').classList.remove('hidden');
    });
  }

  closeModal() {
    document.getElementById('closeModal').addEventListener('click', function() {
      document.getElementById('myModal').classList.add('hidden');
    });
  }
}
