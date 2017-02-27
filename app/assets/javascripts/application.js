// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require_tree .

$(function() {

  // Ajax call for search by project_title
  $('.search input[type="submit"]').click(function(event){
    event.preventDefault();

    $.ajax({
      url: "/projects/?project_title=" + $("input#project_title").val(),
      method: "GET",
      dataType: 'json'

    }).done(function(data){
      console.log(data);
      for(var i=0; i < data.length; i++){
        var list = '<a class="project-link" href="/projects/' + data[i].id + '"><figure class="project-image"><img src="/assets/' + data[i].image + '"></figure><h1 class="project-title">' + data[i].title+ '</h1>';

        $('#search_results').append(list);
        //$("input#project_title").reset();
    }

    }).fail(function(jqXHR, textStatus, errorThrown){
      console.log('Ajax Request Failed');
      console.log(jqXHR);
    }).always(function(){
      console.log('Ajax Request Sent');
    });
  });

  // Ajax call for search by category
  $('.search > a').click(function(event){
    event.preventDefault();

    var link = $(this);
    // console.log(link);
    console.log(link.attr('href'));

    $.ajax({
      url:  $(this).attr('href'),
      method: "GET",
      dataType: 'json'

    }).done(function(data){

      //console.log(data);
      for(var i=0; i < data.length; i++){
        var list = '<a class="project-link" href="/projects/' + data[i].id + '"><figure class="project-image"><img src="/assets/' + data[i].image + '"></figure><h1 class="project-title">' + data[i].title+ '</h1>';

        $('#search_results').append(list);
      }

    }).fail(function(jqXHR, textStatus, errorThrown){
      console.log('Ajax Request Failed');
      console.log(jqXHR);
    }).always(function(){
      console.log('Ajax Request Sent');
    });
  });

});
