import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.updateCount()
  }

  updateCount() {
    const count = document.querySelectorAll('.card').length
    console.log('Counted cards:', count);
    document.getElementById('location-count').textContent = count
  }
}
