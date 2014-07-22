function onInputBoxChanged(inputBox) {
    var userInput = inputBox.val();
    var expected = inputBox.attr('data-solution');
    var isCorrect = userInput === expected;

    if ( isCorrect ) {
        inputBox.addClass('correct');
    }
    else {
        inputBox.removeClass('correct');
    }
}

function setupInputBoxes() {
    $(".input-box").each( function() {
        var box = $(this);

        box.change( function() {
            onInputBoxChanged(box);
        } );
    } );
}

function setupRevealers() {
    $(".revealer-group").each( function() {
        var group = $(this);

        group.find("button.revealer").click( function () {
            var button = $(this);
            var shows = button.attr('data-reveals');

            group.find(".revealed").css({"display":"none"});
            group.find("[data-revealed-by=" + shows + "]").css({"display":"block"});
        } );
    } );
}

function setup() {
    setupInputBoxes();
    setupRevealers();
}

$(document).ready( setup );
