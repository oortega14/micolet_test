import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['button', 'emailInput', 'checkboxes'];
  static errorPresent = false;

  connect() {
    this.buttonTarget.disabled = true;
  }

  onChange(e) {
    const emailInput = this.element.querySelector('input.emailInput');
    const email = emailInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const spanMessage = this.element.querySelector('span.message');;

    if (!emailRegex.test(email)) {
      emailInput.classList.add('error');
      spanMessage.textContent = 'Email no válido';

      if (!this.constructor.errorPresent) {
        spanMessage.classList.add('error-message');
        this.constructor.errorPresent = true;
      }
    } else {
      emailInput.classList.remove('error');
      spanMessage.textContent = '';
      this.constructor.errorPresent = false;
    }

    this.checkIfAnyCheckboxChecked();
  }

  checkIfAnyCheckboxChecked() {
    const checkboxes = this.checkboxesTargets;
    const checked = Array.from(checkboxes).some((checkbox) => checkbox.checked);
    if (checked && !this.constructor.errorPresent) {
      this.buttonTarget.disabled = false;
    } else {
      this.buttonTarget.disabled = true;
    }
  }
}