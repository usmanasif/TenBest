'use strict';
var count = 0;
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

  $('#add-new-field').click(function () {
    const html = '<div class="form-group"><div class="col-md-4"><label class="control-label col-md-4" for="settings">Field:</label><input class="form-control col-sm-8" name="company[setting][' + count + '][key]"/></div><div class="col-sm-8"><label class="control-label col-md-3" for="settings">Value:</label><input class="form-control col-md-8" type="text" name="company[setting][' + count + '][value]"><span class="col-sm-1 col-md-1"><icon onClick="deleteParent(event)" >&#10006;</icon></span></div></div><br><br>'
    $(html).insertBefore('form:last .form-group:last-child:last');
    count++;
  })
});