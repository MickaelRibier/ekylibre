# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "leaflet" # @1.9.4
pin "leaflet-providers" # @2.0.0
pin "leaflet-draw" # @1.0.4
pin "@geoman-io/leaflet-geoman-free", to: "@geoman-io--leaflet-geoman-free.js" # @2.16.0