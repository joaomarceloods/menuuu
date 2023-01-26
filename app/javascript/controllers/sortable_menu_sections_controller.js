import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  connect() {
    this.#configureSortable()
  }

  #configureSortable() {
    this.sortable = new Sortable.create(this.element, {
      group: "menu_sections",
      animation: 150,
      onEnd: this.#handleDragEnd.bind(this),
    })
  }

  #handleDragEnd(event) {
    const { newIndex, item: { dataset: { updateUrl }} } = event

    patch(updateUrl, {
      body: JSON.stringify({
        menu_section: {
          position: newIndex + 1,
        }
      }),
      responseKind: "json",
    })
  }
}
