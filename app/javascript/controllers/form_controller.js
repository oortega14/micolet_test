import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['button', 'emailInput', 'checkboxes'];
  static errorPresent = false;

  connect() {
    this.buttonTarget.disabled = true;
  }

  onChange(e) {
    const emailInput = this.element.querySelector('input.emailInput');
    console.log(this.emailInputTarget.value)
    const parentDiv = emailInput.parentNode;
    const email = emailInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
      emailInput.classList.add('error');
      parentDiv.nextElementSibling.textContent = 'Email no válido';

      const targetSpan = this.element.querySelector('span.message');
      if (!this.constructor.errorPresent) {
        targetSpan.classList.add('error-message');
        this.constructor.errorPresent = true;
      }
    } else {
      emailInput.classList.remove('error');
      parentDiv.nextElementSibling.textContent = '';
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