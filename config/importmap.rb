# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'tailwindcss-stimulus-components' # @5.1.1
pin '@hotwired/stimulus', to: '@hotwired--stimulus.js' # @3.2.2
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.esm.js'
pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.4.1/dist/chart.js'
pin '@kurkle/color', to: 'https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js'
pin 'three' # @0.165.0
