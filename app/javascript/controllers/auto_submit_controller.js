import { Controller } from "@hotwired/stimulus"
import debounce from "lodash.debounce"

// Apply this controller to a form element to automatically submit it upon input changes.
export default class extends Controller {
  connect() {
    this.input = debounce(this.input, 300).bind(this)
    this.#restoreActiveElement()
  }

  // input->auto-submit#input
  input() {
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.element.requestSubmit()
  }

  // turbo:before-stream-render@window->auto-submit#beforeStreamRender
  beforeStreamRender() {
    this.#storeActiveElement()
  }

  #restoreActiveElement() {
    if (window.menuuu?.autoSubmitController?.activeElementInfo) {

      const { parentElementId, activeElementId, selectionStart, selectionEnd, selectionDirection } = window.menuuu.autoSubmitController.activeElementInfo

      if (parentElementId != null || activeElementId != null || selectionStart != null || selectionEnd != null || selectionDirection != null) {

        // If the record has just been created, it steals the focus (usually from the 'new record' form).
        // If the record already existed, it steals the focus from its own form (replaced by the Turbo Stream response body).
        const querySelector = this.element.dataset.justCreated
          ? `#${this.element.dataset.parentElementId} #${activeElementId}`
          : `#${parentElementId} #${activeElementId}`

        const activeElement = document.querySelector(querySelector)

        if (this.element.contains(activeElement)) {
          activeElement.focus()
          activeElement.selectionStart = selectionStart
          activeElement.selectionEnd = selectionEnd
          activeElement.selectionDirection = selectionDirection

          window.menuuu.autoSubmitController.activeElementInfo = undefined
        }
      }
    }
  }

  #storeActiveElement() {
    if (this.element.contains(document.activeElement)) {
      const parentElementId = this.element.dataset.parentElementId
      const activeElementId = document.activeElement.id
      const { selectionStart, selectionEnd, selectionDirection } = document.activeElement

      window.menuuu = {
        ...window.menuuu,
        autoSubmitController: {
          activeElementInfo: { parentElementId, activeElementId, selectionStart, selectionEnd, selectionDirection }
        }
      }
    }
  }
}
