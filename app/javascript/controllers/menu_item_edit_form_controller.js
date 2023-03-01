import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = ["nameInput"]

  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#focusIfJustCreated()
  }

  // input->menu-item-edit-form#input
  input() {
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.element.requestSubmit()
  }

  // keypress:enter->menu-item-edit-form#keypressEnter
  keypressEnter() {
    this.#focusOnNextInput()
  }

  #focusIfJustCreated() {
    if (this.element.dataset.justCreated === 'true') {
      this.nameInputTarget.focus()
    }
  }

  // Source: https://stackoverflow.com/a/35173443/4668975
  #focusOnNextInput() {
    if (document.activeElement) {
      const focussableElementsQuery = 'input[type=text]:not([disabled])';

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
