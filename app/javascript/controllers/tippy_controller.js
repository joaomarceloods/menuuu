import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    allowHtml: Boolean,
    content: String,
    interactive: Boolean,
    placement: String,
  }

  connect() {
    tippy(this.element, {
      allowHTML: this.allowHtmlValue,
      content: this.contentValue,
      interactive: this.interactiveValue,
      placement: this.placementValue,
    });
  }
}
