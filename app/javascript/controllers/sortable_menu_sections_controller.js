import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.#configureSortable()
  }

  #configureSortable() {
    this.sortable = new Sortable.create(this.element, {
      group: "menu_sections",
      handle: ".sortable-handle",
      animation: 150,
      onEnd: this.#handleDragEnd.bind(this),
    })
  }

  #handleDragEnd(event) {
    const { newIndex, item } = event
    const form = item.querySelector('[data-sortable-menu-sections-form]')
    form.elements.menu_section_position.value = newIndex + 1
    form.requestSubmit()
  }
}
