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
$(document).on('turbolinks:load', function () {
  order_index = 7;
  order_column = 2;
  bSortable_columns = [
    { "bSortable": false },
    { "bSortable": true },
    { "bSortable": false },
    { "bSortable": false },
    { "bSortable": false },
    { "bSortable": false },
    { "bSortable": true }
  ]
  if ($.fn.dataTable.isDataTable('#pronoun_orders_table')) {
    table = $('#pronoun_orders_table').DataTable();
  }
  else {
    table = $('#pronoun_orders_table').dataTable({
      autoWidth: false,
      sPaginationType: "full_numbers",
      iDisplayLength: 10,
      bLengthChange: false,
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      order: [],
      sAjaxSource: $('#pronoun_orders_table').data('source'),
      aoColumns: bSortable_columns,
      fnCreatedRow: function (nRow, aData, iDataIndex) {
        $(nRow).attr('id', $(aData[order_index]).val());
        $(nRow).attr('field', 'orders');
      },
      fnDrawCallback: function (oSettings) {
      }
    });

    $(".dataTables_filter_search_input").tooltip();
    $(".dataTables_paginate").addClass('text-center');
  }
});