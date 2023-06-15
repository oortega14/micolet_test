import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect() {
    this.element.classList.add('show') // Añade la clase 'show' para mostrar el toast
  }
}