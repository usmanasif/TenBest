$(document).on('click', '.add_link', function() {
  $('#add-new-link').modal('show');
});
$(document).on('click', '.active_checkbox', function(event) {
  if ($('.active_error').length) {
    event.preventDefault();
    event.stopPropagation();
  }
});
$(document).on('click', '.add_variable', function(event) {
  if ($('#new_name').val().length > 12 || $('#edit_name').val().length > 12) {
    event.preventDefault();
    alert("link name cannot be greater than 12 characters");
  }
});
