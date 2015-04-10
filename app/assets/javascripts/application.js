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
//= require best_in_place
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require annyang
//= require bootstrap-sprockets
//= require_tree .




$(document).on('page:load',function(){
   hideElements();
    newFormUploadType();
    $('.best_in_place').best_in_place();
    allOnClicks();
    if (annyang) {
        annyang.addCommands(commands);
        annyang.debug();
    }
    checkForTitle()
});


window.onload = function(){
    hideElements();
    $('.best_in_place').best_in_place();
    allOnClicks();
    newFormUploadType();
    if (annyang) {
        annyang.addCommands(commands);
        annyang.debug();
    }
    checkForTitle()


};

function navLinks(){
    $('.two_page_link').click(function(){
        viewer.setLayout(Crocodoc.LAYOUT_PRESENTATION_TWO_PAGE)
    });

    $('.fullscreen_link').on('click', function(){
        viewer.enterFullscreen();
    });

    $('.single_page_link').click(function(){
        viewer.setLayout(Crocodoc.LAYOUT_VERTICAL_SINGLE_COLUMN);
    });

    $('.next_page_link').on('click', function(){
        viewer.scrollTo(Crocodoc.SCROLL_NEXT);
    });

    $('.previous_page_link').on('click', function(){
        viewer.scrollTo(Crocodoc.SCROLL_PREVIOUS);
    });

    $('.zoom_out_link').on('click', function(){
        viewer.zoom(Crocodoc.ZOOM_OUT);
    });

    $('.zoom_in_link').on('click', function(){
        viewer.zoom(Crocodoc.ZOOM_IN);
    });

    $('.fit_zoom_link').on('click', function(){
        viewer.zoom(Crocodoc.ZOOM_FIT_HEIGHT);

    });

    $('.fit_width').on('click', function(){
        viewer.zoom(Crocodoc.ZOOM_AUTO);
    });
} //PDF VIEWER LINK FUNCTIONS//

function hideElements(){
    setTimeout(function(){
        $('.flashes').fadeOut();
    }, 2500);

    $('.user_edit').hide();
    $('.hide_me').hide();
    $('.how_to').hide();
    $('.after_view_command').hide();



} //ELEMENTS THAT NEED TO BE HIDDEN ON PAGE LOAD//

function newFormUploadType(){
    $('.url-upload').hide();
    $('.computer-upload').hide();

    $('.upload-by-url').on('click', function(e){
        $('.computer-upload').hide();
        $('.upload-by-computer').removeClass('disabled');
        e.preventDefault();
        $('.upload-by-url').addClass('disabled');
        $('.url-upload').show();
    });

    $('.upload-by-computer').on('click', function(e){
        $('.url-upload').hide();
        $('.upload-by-url').removeClass('disabled');
        e.preventDefault();
        $('.upload-by-computer').addClass('disabled');
        $('.computer-upload').show();
    });
}


//ON CLICK FUNCTIONS//

function allOnClicks(){
    $('.new_doc_submit').on('click', function(){
        $(this).replaceWith("<img src='https://s3.amazonaws.com/voicepdf/images/ajax-loader.gif'><br><p>Uploading...</p>");
        $('form').submit();
    });

    $('.view_commands').on('click', function(){
        $('.hide_upload').fadeOut();
        $('.how_to').fadeIn();
        $(this).hide();
        $('.after_view_command').fadeIn();
    })


}

//FUNCTIONS FOR VOICE COMMANDS//
    var sign_in = function() {
        $('.signin_link').trigger('click')
    };

    var create_user = function(){
        $('.create_user').trigger('click');
    };

    var back_link = function() {
        $('.back_link').trigger('click')
    };

    var next_page =  function(){
        $('.next_page_link').trigger('click')
    };

    var go_to_page = function(term){
        viewer.scrollTo(term)
    };

    var previous_page = function(){
        $('.previous_page_link').trigger('click')
    };

    var zoom_out =  function(){
        $('.zoom_out_link').trigger('click')
    };

    var zoom_fit_height = function(){
        $('.fit_zoom_link').trigger('click')
    };

    var sign_up = function() {
        $('.signup_link').trigger('click');
        $('.try-out').children().fadeOut();
        $('.hide_me').fadeIn(1500);


    };

    var zoom_in = function(){
        $('.zoom_in_link').trigger('click')
    };

    var zoom_width = function(){
        $('.zoom_width').trigger('click')
    };

    var single_page = function (){
        $('.single_page_link').trigger('click')
    };

    var two_page = function(){
        $('.two_page_link').trigger('click')
    };

    var exit_fullscreen = function(){
        viewer.exitFullscreen()
    };
//END FUNCTIONS FOR VOICE COMMANDS//


//COMMANDS THAT CAN BE USED//

    //Application Commands//
    var commands = {

        'sign in (sign in)':sign_in,
        'sign up (sign up)': sign_up,
        '(go) back (page)': back_link,
        'create (create)(user)': create_user

    };
    //End Application Commands//

    //Document Commands//
    var commands2  = {

        //Go Back A Page//
        'back': previous_page,
        'previous (page)': previous_page,
        'last (page)': previous_page,

        //Go To Next Page//
        '(go)(to) page *term': go_to_page,
        'go to (page) *term': go_to_page,
        'forward (forward)': next_page,
        'next (page)(slide)(one)': next_page,


        //Zoom Functions//
        'zoom (in)(zoom)(closer)': zoom_in,
        'zoomin (zoomin)(zoom in)': zoom_in,
        'closer (closer)': zoom_in,
        'move in (closer)': zoom_in,

        'zoom out (zoom out)': zoom_out,
        'zoom away (from)': zoom_out,

        'fit (page)': zoom_fit_height,
        'zoom fit (zoom fit)': zoom_fit_height,
        'fit screen (fit screen)': zoom_fit_height,
        'show all (show all)': zoom_fit_height,
        'fit width': zoom_width,
        'fit with': zoom_width,
        'exit (exit)(fullscreen)': exit_fullscreen,

        //Layout View//
        'single page (zoom)(layout)': single_page,
        '(show )(only) one page': single_page,

        '(show) two page(s) (view)(layout)': two_page





    };
    //End Document Commands//

//END COMMANDS//

function checkForTitle(){
    if( $('#document_title').length <= 1 ) {
        $('.new_doc_submit').addClass('disabled');
    }

    $('#document_title').on('change', function(){
        if ($(this).val() ){
            $('.new_doc_submit').removeClass('disabled');
        } else{
            $('.new_doc_submit').addClass('disabled');
        }
    })

}