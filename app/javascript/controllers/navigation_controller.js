import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "dropdownMenu",
    "dropdownMenuButton",
  ]

  handleDropdownMenuButtonClick() {
    if (this.dropdownMenuTarget.style.maxHeight == "0px") {
      // open
      this.dropdownMenuTarget.style.maxHeight = "200px"
      this.dropdownMenuButtonTarget.children[0].innerText = "close"
    } else {
      // close
      this.dropdownMenuTarget.style.maxHeight = "0px"
      this.dropdownMenuButtonTarget.children[0].innerText = "menu"
    }
  }
}
