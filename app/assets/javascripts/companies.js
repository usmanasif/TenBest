'use strict';
// This count for additional fields is overwridden by index from form view
function deleteParent(event) {
  event.preventDefault();
  $(event.target).parents('.form-group').remove();
}
$(document).on('turbolinks:before-visit', function(){
  var table = $('#companies');
  if (table.length) {
    var dt = table.data('my-dt');
    dt.destroy();
  }
});

$(document).on('turbolinks:load',function(){
  var table = $('#companies');
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
        { "bSortable": true },
        { "bSortable": false },
        { "bSortable": false },
        { "bSortable": false }
      ],
      sAjaxSource: table.data('source')
    });

  table.data('my-dt', dt);

  $('#category_from').hide();
  $('#add_category').on('click', function () {
    // Show new category form and hide import csv from for the moment
    $('#category_from').show();
    $("#import_csv_from").hide();
  });
 
  $("#category_from").on("ajax:complete", function(xhr, data, status) {
    data = $.parseJSON(data.responseText);
    //If Category already exists then null is returned in id
    if(data.id !== null)
    {
      $('#category').append('<option value="' + data.id + '">' + data.value + '</option>');
      $("#category").val(data.id);
      alert("Category Created Successfully");
    }
    else
    {
      alert("Category Already Exists");
    }
    // Show import csv form and hide new category from
    $('#category_from').hide();
    $("#import_csv_from").show();
  });

  $('#category_keywords').tagsinput();

  var count = parseInt( $('#field-count').html());

  $('#add-new-field').click(function () {
    const html = '<div class="form-group"><div class="row"><div class="col-md-5"><label class="control-label col-sm-2" for="settings">Field:</label><div class="col-sm-10"><input class="form-control" name="company[setting][' + count + '][key]"/></div></div><div class="col-sm-6"><label class="control-label col-sm-2" for="settings">Value:</label><div class="col-sm-10"><input class="form-control" type="text" name="company[setting][' + count + '][value]"></div></div><div class="col-sm-1 icon-close"><icon onClick="deleteParent(event)" >&#10006;</icon></div></div></div>'
    $(html).insertBefore('form:last .form-group:last-child:last');
    count++;
  })

  $(".dataTables_filter_search_input").tooltip();
  $(".dataTables_paginate").addClass('text-center');
});