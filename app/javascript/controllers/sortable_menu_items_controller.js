import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

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
    const { to: newList, newIndex, item } = event

    const newForm = item.querySelector('[data-new-form]')
    newForm.menu_item_menu_section_id.value = newList.dataset.sortableMenuItemsMenuSectionId
    newForm.menu_item_position.value = newIndex + 2

    const editForm = item.querySelector('[data-edit-form]')
    editForm.elements.menu_item_menu_section_id.value = newList.dataset.sortableMenuItemsMenuSectionId
    editForm.elements.menu_item_position.value = newIndex + 1
    editForm.requestSubmit()
  }
}
