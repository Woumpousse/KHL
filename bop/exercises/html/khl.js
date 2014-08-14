function initialize()
{
    function newElement(tag)
    {
        return $(document.createElement(tag));
    }

    function giveQuestionsIds()
    {
        var counter = 1;

        function nextId()
        {
            return "question" + counter++;
        }

        $('.question').each( function  () {
            var element = $(this);
            var id = element.attr('id');
            
            if ( !id )
            {
                id = nextId();
            }

            element.attr('id', id);
        } );
    }

    function addSolutionCheckers()
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
    
    function setupHints()
    {
        function hintButtonIdForQuestion(questionId)
        {
            return questionId + '-hintbutton';
        }

        function hintBoxIdForQuestion(questionId)
        {
            return questionId + '-hintbox';
        }

        function addHintButtons()
        {
            function createHintButton(questionId)
            {
                var buttonId = hintButtonIdForQuestion(questionId);
                var boxId = hintBoxIdForQuestion(questionId);
                
                var hintButton = newElement("a");
                hintButton.addClass('hint-button');
                hintButton.attr('id', buttonId);
                hintButton.attr('href', '#' + boxId);
                hintButton.append('?');

                return hintButton;
            }

            $('.question').each( function () {
                var question = $(this);                
                var questionId = question.attr('id');
                var hintButton = createHintButton(questionId);

                question.prepend(hintButton);
            } );
        }

        function transformHintsToPopups()
        {
            $('.hint').wrap( function() {
                var hint = $(this);
                var question = hint.parents('.question').first();
                var questionId = question.attr('id');
                var hintBoxId = hintBoxIdForQuestion(questionId);

                return "<div class=\"popup\" id=\"" + hintBoxId + "\"></div>";
            } );
        }

        addHintButtons();
        transformHintsToPopups();
    }

    giveQuestionsIds();
    addSolutionCheckers();
    setupHints();
}

$(initialize);
