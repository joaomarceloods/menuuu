import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

export default class extends Controller {
  static targets = [
    "newForm",
    "editForm",
  ]

  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#autofocus()
  }

  // input->menu-item-form#input
  input() {
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.editFormTarget?.requestSubmit()
  }

  // keypress:enter->menu-item-form#keypressEnter
  keypressEnter() {
    this.#hackMobileSafariFocus()
    this.newFormTarget?.requestSubmit()
  }

  #autofocus() {
    document.querySelector("[autofocus]")?.focus()
  }

  // On Mobile Safari, applying focus to an element asynchronously doesn't show the keyboard.
  // To work around that:
  // 1. Synchrounously append an invisible input to the document and focus on it, to keep the keyboard open.
  // 2. The incoming element from Turbo will call this.#autofocus() to steal the focus.
  #hackMobileSafariFocus() {
    document.querySelector(".hack-mobile-safari-focus")?.remove()
    const fakeInput = document.createElement('input')
    fakeInput.className = "hack-mobile-safari-focus"
    document.body.prepend(fakeInput)
    fakeInput.focus()
  }
}
