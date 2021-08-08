// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@popperjs/core')
var bootstrap = require('bootstrap')
require('onscreen')
require('nouislider')
var Swal = require('sweetalert2')
var moment = require('moment')
require('vanillajs-datepicker')
require('notyf')
require('simplebar')
var simpleDatatables = require('simple-datatables')
require('dropzone')
window.bootstrap = bootstrap;
window.Swal = Swal;
window.simpleDatatables = simpleDatatables;
require('packs/volt')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
moment.locale('fr');