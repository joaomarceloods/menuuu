import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["formattedInput"]

  connect() {
    debugger
    this.#createHiddenInput()
    this.handleInput()
  }

  #createHiddenInput() {
    this.hiddenInput = document.createElement('input')
    this.hiddenInput.type = 'hidden'
    this.hiddenInput.name = this.formattedInputTarget.name
    this.hiddenInput.value = this.formattedInputTarget.value
    this.formattedInputTarget.after(this.hiddenInput)
  }

  // Show formatted currency to the user but use digits-only on the hidden input to be posted to the server
  handleInput() {
    if (!this.formattedInputTarget.value) return
    const digitsOnly = this.formattedInputTarget.value.replace(/\D+/g, '')
    const formatter = new Intl.NumberFormat(undefined, { minimumFractionDigits: '2', maximumFractionDigits: '2' })
    this.formattedInputTarget.value = formatter.format(digitsOnly / 100)
    this.hiddenInput.value = parseInt(digitsOnly)
  }
}
