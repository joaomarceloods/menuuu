import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#focusIfJustCreated()
  }

  // input->menu-item-form#input
  input() {
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.element.requestSubmit()
  }

  // enter->menu-item-form#enter
  enter() {
    this.#focusOnNextElement()
  }

  #focusIfJustCreated() {
    if (this.element.dataset.justCreated === 'true') {
      const activeElement = document.activeElement
      const newMenuItemForm = document.getElementById('new_menu_item')

      if (newMenuItemForm.contains(activeElement)) {
        const oldActiveElement = activeElement
        const newActiveElement = document.querySelector(
          `#${this.element.dataset.parentElementId} #${oldActiveElement.id}`
        )

        if (newActiveElement) {
          const { selectionStart, selectionEnd, selectionDirection } = oldActiveElement
          newActiveElement.focus()
          newActiveElement.selectionStart = selectionStart
          newActiveElement.selectionEnd = selectionEnd
          newActiveElement.selectionDirection = selectionDirection
        }
      }
    }
  }

  #focusOnNextElement() {
    if (document.activeElement && document.activeElement.form) {
      const focussableElementsQuery = 'a:not([disabled]), button:not([disabled]), input[type=text]:not([disabled]), [tabindex]:not([disabled]):not([tabindex="-1"])';

      const focussableElements = document.querySelectorAll(focussableElementsQuery).filter(
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
