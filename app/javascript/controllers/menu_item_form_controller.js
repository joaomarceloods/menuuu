import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = [
    "newForm",
    "editForm",
  ]

  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#formatPrice()
  }

  // input->menu-item-form#input
  input() {
    this.#formatPrice()
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.editFormTarget?.requestSubmit()
  }

  #formatPrice() {
    if (!this.hasEditFormTarget) return
    const priceInput = this.editFormTarget.querySelector(".menu-item-price")
    if (!priceInput || !priceInput.length) return
    priceInput.value = parseFloat(priceInput.value).toFixed(2)
  }

  // keypress:enter->menu-item-form#keypressEnter
  keypressEnter() {
    // this.#focusOnNextInput()
    this.newFormTarget?.requestSubmit()
  }
}
