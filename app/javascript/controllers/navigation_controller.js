import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "dropdownMenu",
    "dropdownMenuButton",
  ]

  handleDropdownMenuButtonClick() {
    const expandedClass = "navigation__menu--expanded"
    this.dropdownMenuTarget.classList.toggle(expandedClass)
    this.dropdownMenuButtonTarget.children[0].innerText =
      this.dropdownMenuTarget.classList.contains(expandedClass)
        ? "close"
        : "menu"
  }
}
