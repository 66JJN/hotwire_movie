import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category"
export default class extends Controller {
  static targets = ["count" , "item"]
  
  connect() {
    console.log("categories");
    
  }
  toggle() {
    console.log(this.countTarget);
    
    console.log(this.itemTargets.length);
  }
}
