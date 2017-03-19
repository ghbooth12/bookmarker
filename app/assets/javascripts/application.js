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
//= require turbolinks
//= require bootstrap
//= require_tree .

// application.js
var analytics_app = {};
analytics_app.report = function(eventName){
  var event = { event: { name: eventName } };
  var request = new XMLHttpRequest();

  request.open("POST", "http://analytics-app-ghbooth12.herokuapp.com/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');
  request.send(JSON.stringify(event));
};

// ============ e.g., Track "click" event on "#target-element" element. ============
$(document).ready(function(){
  $('#steps a').on("click", function(){
    analytics_app.report("<a> tags clicked from the greeting section");
  });
});

$(document).ready(function(){
  $('section .margin-none a').on("click", function(){
    analytics_app.report("New bookmark URL Created");
  });
});

$(document).ready(function(){
  $('.fa-heart').on("click", function(){
    analytics_app.report("Voting up");
  });
});
