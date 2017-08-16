// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-switch
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require social-share-button
//= require bootstrap-tagsinput
//= require_tree .
//= require turbolinks

function get(url, success, error) {
    $.ajax({
        async: true,
        crossDomain: true,
        method: "GET",
        url: url,
        contentType: "application/x-www-form-urlencoded",
        dataType: "text/json",
        success: success,
        error: error
    }).done(function (msg) {
        if (console && console.log) {
            console.log("Sample of data:", msg.slice(0, 100));
        }
    }).fail(function (jqXHR, textStatus) {
        alert("Request failed: " + textStatus);
    });
}

function post(url, data, success, error) {
    $.ajax({
        async: true,
        crossDomain: true,
        method: "POST",
        url: url,
        contentType: "application/x-www-form-urlencoded",
        dataType: "text/json",
        success: success,
        error: error
    }).done(function (msg) {
        if (console && console.log) {
            console.log("Sample of data:", msg.slice(0, 100));
        }
    }).fail(function (jqXHR, textStatus) {
        alert("Request failed: " + textStatus);
    });
}
$(document).ready(function () {
    return setTimeout((function () {
        return $('.alert').slideUp();
    }), 3000);
});
$(document).ready(function () {
    $('.bootstrap-switch').bootstrapSwitch();
})