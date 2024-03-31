import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.handleChange()
  }

  handleChange() {
    if (!this.element.value) return
    const digitsOnly = this.element.value.replace(/\D+/g, '')
    const format = new Intl.NumberFormat(undefined, { minimumFractionDigits: '2', maximumFractionDigits: '2' })
    const formatted = format.format(digitsOnly / 100)
    this.element.value = formatted
  }
}
