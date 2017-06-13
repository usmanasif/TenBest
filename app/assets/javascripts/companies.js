$(document).on('turbolinks:load',function(){
  jQuery(function() {
  return $('#companies').dataTable({
      sPaginationType: "full_numbers",
      bJQueryUI: true,
      bProcessing: true,
      bServerSide: true,
      bSortable: true,
      sAjaxSource: $('#companies').data('source')
      // columns: [
      //   { data: "id" },
      //   { data: "id" },
      //   { data: "id" },
      //   { data: "id" },
      //   { data: "id", render: function(record)
      //     {
      //       "<a href='#{record.url}'>edit</a> <a href='#{record.url}'>remove</a>"
      //     }
      //   },
      // ]
    });
  });
  $('#category_keywords').tagsinput();
});
