import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.#handleDragEnd.bind(this)
    this.#configureSortable()
  }

  #configureSortable() {
    this.sortable = new Sortable.create(this.element, {
      group: 'menu_items',
      animation: 150,
      onEnd: this.#handleDragEnd,
    })
  }

  #handleDragEnd(event) {
    const { to: newList, newIndex, item: { dataset: { sortableUrl }} } = event
    console.log(newList, newIndex, sortableUrl)
  }
}
