import { Controller } from "@hotwired/stimulus"

// Submits the form when a field changes, e.g. a filter <select>.
// requestSubmit() (not submit()) so Turbo handles the submission.
// <form data-controller="auto-submit">
//   <select data-action="change->auto-submit#submit">…</select>
// </form>
export default class extends Controller {
  submit() {
    this.element.requestSubmit()
  }
}
