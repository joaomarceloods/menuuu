import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#formatPrice()
  }

  // input->menu-item-form#input
  input() {
    this.#formatPrice()
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.element.requestSubmit()
  }

  #formatPrice() {
    const priceInput = this.element.querySelector(".menu-item-price")
    if (!priceInput) return
    priceInput.value = parseFloat(priceInput.value).toFixed(2)
  }

  // keypress:enter->menu-item-form#keypressEnter
  keypressEnter() {
    this.#focusOnNextInput()
  }

  // Source: https://stackoverflow.com/a/35173443/4668975
  #focusOnNextInput() {
    if (document.activeElement) {
      const focussableElementsQuery = 'input:not([disabled])';

      const focussableElements = [...document.querySelectorAll(focussableElementsQuery)].filter(
        element => element.offsetWidth > 0 || element.offsetHeight > 0 || element === document.activeElement
      )

      const index = focussableElements.indexOf(document.activeElement)

      if (index > -1) {
        const nextElement = focussableElements[index + 1] || focussableElements[0]
        nextElement.focus()
      }
    }
  }
}
