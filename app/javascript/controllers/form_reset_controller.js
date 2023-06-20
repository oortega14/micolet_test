import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-reset"
export default class extends Controller {
  static targets = ["form"];

  resetForm() {
    this.formTarget.reset();
  }
}
