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




$(document).on('page:load',function(){
    $('.login_form').hide();
    $('.user_edit').hide();



});


window.onload = function(){
    $('.user_edit').hide();
    $('.login_form').hide();
    nextPage();



    if (annyang) {

        annyang.addCommands(commands);
        annyang.debug();

    }
};



var greeting = function() {
    $('#greeting').append('<h1>Hello!</h1>');
};

var sign_in = function() {
    $('.signin_link').trigger('click')
};

var back_link = function() {
    $('.back_link').trigger('click')
};

var next_page = function(){
    viewer.scrollTo(Crocodoc.SCROLL_NEXT);

};

var last_page = function(){
    viewer.scrollTo(Crocodoc.SCROLL_PREVIOUS);
};

function nextPage(){
    $('.clickme').on('click', function(){
        viewer.scrollTo(Crocodoc.SCROLL_NEXT);
    });
}


var commands = {
    'hello': greeting,
    'hi' : greeting,

    'sign in':sign_in,
    'back': back_link,
    'go back': back_link(),

    'next page': next_page,
    'next': next_page,

    'previous': last_page,
    'previous page': last_page,
    'last page': last_page,
    'last': last_page,




    'sign up': function() {
        $('.signup_link').trigger('click')
    }

};



