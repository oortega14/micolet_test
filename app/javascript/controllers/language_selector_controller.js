import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="language-selector"
export default class extends Controller {
  static targets = ["select"];

  changeLocale(event) {
    const locale = event.target.value;
    window.location.href = locale;
  }
}
