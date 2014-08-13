function initialize()
{
    $('input').each( function () {
        var input = $(this);

        input.change( function () {
            var expected = input.attr('data-solution');
            var given = input.val();

            if ( expected === given ) {
                input.addClass('correct');
            }
            else {
                input.removeClass('correct');
            }
        } );
    } );
}

$(initialize);
