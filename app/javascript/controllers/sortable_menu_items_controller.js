import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  connect() {
    this.#configureSortable()
  }

  #configureSortable() {
    this.sortable = new Sortable.create(this.element, {
      group: "menu_items",
      handle: ".sortable-handle",
      animation: 150,
      onEnd: this.#handleDragEnd.bind(this),
    })
  }

  #handleDragEnd(event) {
    const { to: newList, newIndex, item: { dataset: { sortableMenuItemsUpdateUrl }} } = event

    patch(sortableMenuItemsUpdateUrl, {
      body: JSON.stringify({
        menu_item: {
          position: newIndex + 1,
          menu_section_id: newList.dataset.sortableMenuItemsMenuSectionId,
        }
      }),
      responseKind: "json",
    })
  }
}
