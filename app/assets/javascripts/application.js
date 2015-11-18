// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require algolia/v3/algoliasearch.min
//= require algolia/typeahead.jquery
//= require hogan.js

//= require_tree .

//= require underscore
//= require gmaps/google

$(function() {
  $(".popover-if-empty").on("change keyup", function() {
    if ($(this).val() == "") {
      $(".popover-if-empty").popover('show');
    } else {
      $(".popover-if-empty").popover('hide');
    }
  })

  $('.address').keyup(function(){
    if($(this).val().length !=0)
      $('.sendButton').attr('disabled', false);
    else
      $('.sendButton').attr('disabled',true);
    })

});

// jQuery show/hide text description

jQuery(function(){

    var minimized_elements = $('.truncate');

    minimized_elements.each(function(){
        var t = $(this).text();
        if(t.length < 400) return;

        $(this).html(
            t.slice(0,400)+'<span>... </span><br><a href="#" class="more">Voir plus</a>'+
            '<span style="display:none;">'+ t.slice(400,t.length)+' <br><a href="#" class="less">Cacher</a></span>'
        );

    });

    $('a.more', minimized_elements).click(function(event){
        event.preventDefault();
        $(this).hide().prev().hide();
        $(this).next().show();
    });

    $('a.less', minimized_elements).click(function(event){
        event.preventDefault();
        $(this).parent().hide().prev().show().prev().show();
    });

});



function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}

function onPlaceChanged() {
  var place = this.getPlace();

  // console.log(place);  // Uncomment this line to view the full object returned by Google API.

  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {  // Some types are ["country", "political"]
      var type_element = document.getElementById(component.types[j]);
      if (type_element) {
        type_element.value = component.long_name;
      }
    }
  }
}

google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('user_input_autocomplete_address');
});



