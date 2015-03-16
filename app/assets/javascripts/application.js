// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require annyang
//= require_tree .


window.onload = function(){
    if (annyang) {
        var commands = {
            'hello': greeting,
            'hi' : greeting,

            'Cameron': function() {
                alert('WOW, Looks like a big baby!');
            },

            'sign up': function() {
                $('.signup_link').trigger('click')
            }

        };
        annyang.addCommands(commands);
        annyang.debug();

    }
};



var greeting = function() {
    $('#greeting').append('<h1>Hello!</h1>');
};