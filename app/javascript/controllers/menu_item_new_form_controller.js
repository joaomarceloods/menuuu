import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // focusin->menu-item-new-form#focusin
  focusin() {
    // Turbo Drive requires usage of requestSubmit() instead of submit().
    // https://turbo.hotwired.dev/handbook/drive#form-submissions
    this.element.requestSubmit()
  }

  keypress(event) {
    event.preventDefault()
  }
}
