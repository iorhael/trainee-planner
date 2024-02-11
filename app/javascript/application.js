// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import '@popperjs/core'
import 'bootstrap'
import { Application } from "@hotwired/stimulus"

const application = Application.start()

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
