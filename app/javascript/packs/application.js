// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from "jquery";
require('@popperjs/core')
var bootstrap = require('bootstrap')
require('onscreen')
require('nouislider')
var Swal = require('sweetalert2')
var moment = require('moment')
var vanillajsDatepicker = require('vanillajs-datepicker')
require('notyf')
require('simplebar')
require('datatables.net')
require('datatables.net-responsive')
var simpleDatatables = require('simple-datatables')
require('dropzone')
var Choices = require('choices.js')

window.bootstrap = bootstrap;
window.Swal = Swal;
window.simpleDatatables = simpleDatatables;
window.vanillajsDatepicker = vanillajsDatepicker;
window.Choices = Choices;
require('packs/volt')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
moment.locale('fr');


global.$ = jQuery;
window.Rails = Rails;

window.fetchDatatable = function fetchDatatable(dtId, data) {
  $(dtId).DataTable({
    responsivePriority: -1,
    language: {
      processing: "Traitement en cours...",
      search: "Rechercher&nbsp;:",
      lengthMenu: "Afficher _MENU_ &eacute;l&eacute;ments",
      info:
        "Affichage de l'&eacute;l&eacute;ment _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
      infoEmpty:
        "Affichage de l'&eacute;l&eacute;ment 0 &agrave; 0 sur 0 &eacute;l&eacute;ment",
      infoFiltered:
        "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
      infoPostFix: "",
      loadingRecords: "Chargement en cours...",
      zeroRecords: "Aucun &eacute;l&eacute;ment &agrave; afficher",
      emptyTable: "Aucune donn&eacute;e disponible dans le tableau",
      decimal: ",",
      thousands: " ",
      paginate: {
        first: "Premier",
        previous: "Pr&eacute;c&eacute;dent",
        next: "Suivant",
        last: "Dernier",
      },
      aria: {
        sortAscending:
          ": activer pour trier la colonne par ordre croissant",
        sortDescending:
          ": activer pour trier la colonne par ordre d&eacute;croissant",
      },
    },
    destroy: true,
    paginate: true,
    pageLength: 10,
    lengthMenu: [10, 20, 50, 100],
    processing: true,
    order: [[0, "desc"]],
    serverSide: true,
    ajax: {
      url: '/api/datatables',
      type: "GET",
      data: {...data},
    },
    columns: getDatatableColumns(data['model']),
  });
}
function getDatatableColumns(modelName) {
  let columns = [];
  switch (modelName) {
      case 'placed-bets':
          columns = [
            {
              data: "sender_cb",
              className: "all",
              width: "10%",
            },
            {
              data: "msisdn",
              orderable: false,
              searchable: true,
            },
            {
              data: null,
              orderable: false,
              searchable: false,
              className: "all",
              width: "10%",
              render(data, type, row, meta) {
                return row.draws.map(num => `<span class="badge bg-primary"> ${num} </span>`);
              },
            },
            {
              data: "bet_date",
              className: "all",
              orderable: true,
              searchable: false,
              width: "5%",
            },
            {
              data: null,
              orderable: true,
              searchable: false,
              className: "all",
              width: "5%",
              render(data, type, row, meta) {
                return new Intl.NumberFormat().format(row.bet_amount);
              },
            },
            {
              data: null,
              orderable: true,
              searchable: false,
              className: "all",
              width: "5%",
              render(data, type, row, meta) {
                return new Intl.NumberFormat().format(row.winning_amount);
              },
            }];
          break;
      case 'winning-bets':
          columns = [
            {
              data: "transaction_id",
              className: "all",
              width: "10%",
            },
            {
              data: "sender_cb",
              orderable: false,
              searchable: true,
            },
            {
              data: null,
              orderable: true,
              searchable: false,
              className: "all",
              width: "5%",
              render(data, type, row, meta) {
                return new Intl.NumberFormat().format(row.amount);
              },
            },
            {
              data: "msisdn",
              orderable: false,
              searchable: true,
            },
            {
              data: "record_date",
              className: "all",
              orderable: true,
              searchable: false,
              width: "5%",
            },
            {
              data: "payment_ref",
              orderable: false,
              searchable: true,
            }];
          break;
      default:
          break;
  };
  columns.push({
    data: null,
    orderable: false,
    searchable: false,
    className: "all",
    width: "5%",
    render(data, type, row, meta) {
      return showDetailsColumn(row.sender_cb);
    },
  });
  return columns;
};

function showDetailsColumn(id= "") {
  return `<div class="d-block" style="margin-top: -1rem"> <a href="#" class="d-flex align-items-center">
    <div class="icon-shape icon-sm">
      <svg class="text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
        <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
        <path fill-rule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"></path>
      </svg>
      
    </div>
    <span> Voir Détails<span>
  </a></div>`;
}
