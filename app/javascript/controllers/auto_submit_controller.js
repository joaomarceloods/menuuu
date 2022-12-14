import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

// Apply this controller to a form element to automatically submit it upon input changes.
export default class extends Controller {
  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#restoreActiveElement()
  }

  // input->auto-submit#input
  // requestSubmit() dispatches the submit event that Turbo needs to handle, while submit() doesn't.
  input() {
    this.element.requestSubmit()
  }

  // turbo:before-stream-render@window->auto-submit#beforeStreamRender
  // Handles the Turbo Stream response from the server.
  beforeStreamRender() {
    this.#storeActiveElement()
  }

  #restoreActiveElement() {
    if (window.menuuu?.activeElement) {
      const { querySelector, selectionStart, selectionEnd, selectionDirection } = window.menuuu.activeElement

      const inputElement = document.querySelector(querySelector)

      if (this.element.contains(inputElement)) {
        inputElement.focus()
        inputElement.selectionStart = selectionStart
        inputElement.selectionEnd = selectionEnd
        inputElement.selectionDirection = selectionDirection

        window.menuuu.activeElement = undefined
      }
    }
  }

  #storeActiveElement() {
    if (this.element.contains(document.activeElement)) {
      const parentElementId = this.element.dataset.parentId
      const activeElementId = document.activeElement.id
      const querySelector = `#${parentElementId} #${activeElementId}`
      const { selectionStart, selectionEnd, selectionDirection } = document.activeElement

      window.menuuu = {
        ...window.menuuu,
        activeElement: { querySelector, selectionStart, selectionEnd, selectionDirection }
      }
    }
  }
}
