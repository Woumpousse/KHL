function initialize()
{
    function newElement(tag)
    {
        return $(document.createElement(tag));
    }

    function findQuestions()
    {
        return $('[data-question]');
    }

    function processQuestions()
    {
        var assignIdToQuestion = ( function () {
            var counter = 1;

            function nextId()
            {
                return "question" + counter++;
            }

            return function (element) {
                var id = element.attr('id');

                if ( !id )
                {
                    id = nextId();
                }

                element.attr('id', id);
            };                
        } )();

        function assignClassToQuestion(element)
        {
            element.addClass('question');
        }

        findQuestions().each( function  () {
            var element = $(this);

            assignClassToQuestion(element);
            assignIdToQuestion(element);
        } );
    }

    function addInputCheckers()
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
            function containsHintData(questionId)
            {
                return $('#' + questionId + ' .hint').length !== 0;
            }

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

            findQuestions().each( function () {
                var question = $(this);                
                var questionId = question.attr('id');

                if ( containsHintData(questionId) )
                {
                    var hintButton = createHintButton(questionId);
                    question.prepend(hintButton);
                }
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

    function isSelected(element)
    {
        return element.hasClass('selected');
    }

    function addSelectableHandlers()
    {
        function toggleSelection(selectableElement)
        {
            if ( isSelected(selectableElement) )
            {
                selectableElement.removeClass('selected');
            }
            else
            {
                selectableElement.addClass('selected');
            }
        }

        $('.selectable').click( function() {
            var selectableElement = $(this);

            toggleSelection(selectableElement);
        } );
    }

    processQuestions();
    addInputCheckers();
    addSelectableHandlers();
    setupHints();
}

$(initialize);
