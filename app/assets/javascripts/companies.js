$(document).on('turbolinks:load',function(){
  jQuery(function() {
  return $('#companies').dataTable({
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    bProcessing: true,
    bServerSide: true,
    bSortable: true,
    sAjaxSource: $('#companies').data('source')
  });
  });
});
