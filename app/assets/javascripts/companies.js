'use strict';
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
 
  function showImportModal() {
    $("#add-new-category").modal("show");
  }
});