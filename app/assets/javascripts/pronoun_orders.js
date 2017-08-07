'use strict';
$(document).on('click', '#place_order', function (event) {
  $("#place_order_modal").modal("show");
});
$(document).on('click', '#revise_button', function (event) {
  $("#revise_order_modal").modal("show");
});
$(document).on('click', '#reject_button', function (event) {
  $("#revise_order_modal").modal("show");
});

$(document).on('click', '#place_order_submit', function (event) {
  var id = $("#empty_orders").val();
  get("/admin/pronoun_orders/" + id + "/place_order",
    function success(data) {
      alert("Order Placed Successfully");
      $("#place_order_modal").modal("hide");
    },
    function error(error) {
      alert("Error occurred while placing order");
      $("#place_order_modal").modal("hide");
    })
});
$(document).on('turbolinks:before-visit', function(){
  var table = $('#pronoun_orders_table');
  if (table.length) {
    var dt = table.data('my-dt1');
    
    dt.destroy();
  }
});
$(document).on('turbolinks:load',function(){
  var table = $('#pronoun_orders_table');
  var dt = table.DataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      bSortable: true,
      aoColumns: [
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": true }
      ],
      sAjaxSource: table.data('source')
    });

  table.data('my-dt1', dt);

  $(".dataTables_filter_search_input").tooltip();
  $(".dataTables_paginate").addClass('text-center');
    
});