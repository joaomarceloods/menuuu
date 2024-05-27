import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.autosize()
    this.element.addEventListener("input", this.autosize.bind(this))
  }

  disonnect() {
    this.element.removeEventListener("input", this.autosize.bind(this))
  }

  autosize() {
    this.element.style.height = "0"
    this.element.style.height = this.element.scrollHeight + "px"
  }
}
