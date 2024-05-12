import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.#configureSortable()
  }

  #configureSortable() {
    this.sortable = new Sortable.create(this.element, {
      group: "menu_items",
      handle: ".toolbar__item--handle",
      animation: 150,
      onEnd: this.#handleDragEnd.bind(this),
    })
  }

  #handleDragEnd(event) {
    const { to: newList, newIndex, item } = event
    const form = item.querySelector('[data-sortable-menu-items-form]')
    form.elements.menu_item_menu_section_id.value = newList.dataset.sortableMenuItemsMenuSectionId
    form.elements.menu_item_position.value = newIndex + 1
    form.requestSubmit()
  }
}
