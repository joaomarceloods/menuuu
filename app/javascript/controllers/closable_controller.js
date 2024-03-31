import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleCloseButtonClick() {
    this.element.remove()
  }
}
