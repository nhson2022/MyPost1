// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "trix"
import "@rails/actiontext"

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

import LocalTime from "local-time"
LocalTime.start()