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

function setupButtonQuestions() {
    $(".multiple-choice-question").each( function() {
        var question = $(this);

        question.find("button.choice").click( function () {
            var button = $(this);
            var shows = button.attr('data-show');

            question.find("p.feedback").css({"display":"none"});

            question.find("p[data-feedback-to=" + shows + "]").css({"display":"block"});
        } );
    } );
}

function setup() {
    setupInputBoxes();
    setupButtonQuestions();
}

$(document).ready( setup );
