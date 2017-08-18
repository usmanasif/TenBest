var nav_link_parents;
$(document).on('ready', function () {
  if (document.getElementById("nav-link-parents") != null) {
    nav_link_parents = JSON.parse($('#nav-link-parents').html());
  }
})
$(document).on('click', '.add_link', function () {
  $('#add-new-link').modal('show');
});
$(document).on('switchChange.bootstrapSwitch', '#nav_link_active', function (event) {
  if ($('.active_error').length) {
    event.preventDefault();
    event.stopPropagation();
  }
  checkParentLimit($(this).parents('.modal-body').children('.parent-div').children('select').val());
});
$(document).on('click', '.add_variable', function (event) {
  if ($('#new_name').val().length > 30 || $('#edit_name').val().length > 30) {
    event.preventDefault();
    alert("link name cannot be greater than 30 characters");
  }
});

// Check nav links parent select change
$(document).on('change', '#select_parent', function () {
  checkParentLimit($(this).val());
});

// Check Parent nav link children limit exceeding limit
function checkParentLimit(parent_id) {
  var selected_parent = nav_link_parents.find(function (item) {
    return item.id == parent_id;
  })
  if (selected_parent.child_count >= 5) {
    showErrorLabel()
    $(".active_checkbox").bootstrapSwitch('state', false);
  }
  else {
    hideErrorLabel();
  }
}

// Show error on limit exceeding
function showErrorLabel() {
  hideErrorLabel();
  $(".modal-body").prepend('<label class="label label-danger">Parent has reached its active link limit</label>')
}

// hide error on changing selection
function hideErrorLabel() {
  var modal_body = $(".modal-body")
  modal_body.each(function (index, element) {
    if ($(this).children().first().is('label')) {
      var label = $(this).children().first();
      label.remove();
    }
  });
}

$(document).on('click', '.add_category', function () {
  $('#add-category').modal('show');
});
$(document).on('click', '.add_sub_category', function () {
  $('#add-sub-category').modal('show');
});