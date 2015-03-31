/**
 * Created by Gil on 3/31/15.
 */
$('.login_form').hide();
$( window ).load(function() {

    $('#login-button').click(function() {
       $(this).fadeOut();
        $('.login_form').fadeIn();

    });
});


