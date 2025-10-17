import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
	if (!this.choices) {
    		this.choices = new Choices(this.element, {});
	}
  }
}
