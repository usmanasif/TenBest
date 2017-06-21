$(document).on('click', '#place_order', function(event) {
  $("#place_order_modal").modal("show");
});
$(document).on('click', '#revise_button', function(event) {
  $("#revise_order_modal").modal("show");
});
$(document).on('click', '#reject_button', function(event) {
  $("#revise_order_modal").modal("show");
});

$(document).on('click', '#place_order_submit', function(event) {
  var id = $("#empty_orders").val();
  get("/admin/pronoun_orders/" + id + "/place_order",
    function success(data){
        alert("Order Placed Successfully");
        $("#place_order_modal").modal("hide");
    },
    function error(error){
        alert("Error occurred while placing order");
        $("#place_order_modal").modal("hide");
    })
});