function newElement(tag)
{
    return $(document.createElement(tag));
}

var buttons = ( function () {
    function createButton(iconName)
    {
        var button = newElement('div');
        button.addClass('question-control');
        button.css('width', '32px');
        button.css('height', '32px');

        var img = newElement('img');
        img.attr('src', iconName + '.svg');
        img.attr('width', 32);
        img.attr('height', 32);

        button.append(img);

        return button;
    }

    function createVerifyButton()
    {
        var button = createButton('verify');
        button.addClass('verify');
        button.attr('title', 'Verifieer');

        return button;
    }

    function createResetButton()
    {
        var button = createButton('reset');
        button.addClass('reset');
        button.attr('title', 'Reset');

        return button;
    }

    function createRevealButton()
    {
        var button = createButton('reveal');
        button.addClass('reveal');
        button.attr('title', 'Toon oplossing');

        return button;
    }

    function createHintButton()
    {
        var button = createButton('hint');
        button.addClass('hint');
        button.attr('title', 'Hint');

        return button;
    }

    return { createVerifyButton: createVerifyButton,
             createResetButton: createResetButton,
             createRevealButton: createRevealButton
           };
} )();

function initialize()
{
    function findQuestions()
    {
        return $('[data-question]');
    }

    function processQuestions()
    {
        function processSelectionQuestions()
        {
            function isSelected(element)
            {
                return element.hasClass('selected');
            }

            function select(element)
            {
                return element.addClass('selected');
            }

            function deselect(element)
            {
                return element.removeClass('selected');
            }

            function clearAllSelections(question)
            {
                findSelectableChildren(question).each( function () {
                    var selectable = $(this);
                    deselect(selectable);
                } );
            }

            function shouldBeSelected(element)
            {
                return element.attr('data-solution') === 'true';
            }

            function toggleSelection(element)
            {
                if ( isSelected(element) )
                {
                    deselect(element);
                }
                else
                {
                    select(element);
                }
            }

            function clearFeedback(element)
            {
                element.removeClass('correct');
                element.removeClass('incorrect');
            }

            function showFeedback(element)
            {
                var received = isSelected(element);
                var expected = shouldBeSelected(element);

                if ( received && expected )
                {
                    element.addClass('correct');
                }
                else if ( received || expected )
                {
                    element.addClass('incorrect');
                }
            }

            function findSelectableChildren(question)
            {
                return question.find('.selectable');
            }

            function showAllFeedback(question)
            {
                findSelectableChildren(question).each( function() {
                    var child = $(this);
                    showFeedback(child);
                } );
            }

            function clearAllFeedback(question)
            {
                findSelectableChildren(question).each( function () {
                    var child = $(this);

                    clearFeedback(child);
                } );
            }

            function revealSolution(element)
            {
                if ( shouldBeSelected(element) )
                {
                    select(element);
                }
                else
                {
                    deselect(element);
                }
            }

            function revealAllSolutions(question)
            {
                findSelectableChildren(question).each( function () {
                    var child = $(this);

                    revealSolution(child);
                } );
            }

            function isCorrect(element)
            {
                return isSelected(element) === shouldBeSelected(element);
            }

            function addSelectableHandlers()
            {
                $('.selectable').click( function() {
                    var selectableElement = $(this);

                    toggleSelection(selectableElement);
                } );
            }

            function addButtons()
            {
                function createVerifyButton(question)
                {
                    function verify()
                    {
                        clearAllFeedback(question);
                        showAllFeedback(question);
                    }

                    var button = buttons.createVerifyButton();
                    button.click(verify);

                    return button;
                }

                function createResetButton(question)
                {
                    function reset()
                    {
                        clearAllFeedback(question);
                        clearAllSelections(question);
                    }

                    var button = buttons.createResetButton();
                    button.click(reset);
                    
                    return button;
                }

                function createSolutionButton(question)
                {
                    function reveal()
                    {
                        revealAllSolutions(question);
                        showAllFeedback(question);
                    }

                    var button = buttons.createRevealButton();
                    button.click(reveal);

                    return button;
                }

                function createButtonBox(question)
                {
                    var box = findQuestionControlBox(question);

                    box.append( createVerifyButton(question) );
                    box.append( createResetButton(question) );
                    box.append( createSolutionButton(question) );

                    return box;
                }

                $('[data-question="selection"]').each( function () {
                    var question = $(this);

                    question.append( createButtonBox(question) );
                } );
            }

            addSelectableHandlers();
            addButtons();
        }

        function addClassAndIdToAllQuestions()
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

        function processFillInBlankQuestions()
        {
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

            addInputCheckers();
        }

        function addControlBoxesToAllQuestions()
        {
            findQuestions().each( function () {
                var question = $(this);

                var box = newElement('div');
                box.addClass('question-controls');

                question.append(box);
            } );
        }

        function findQuestionControlBox(question)
        {
            return question.find(".question-controls").first();
        }

        addClassAndIdToAllQuestions();
        addControlBoxesToAllQuestions();
        processSelectionQuestions();
        processFillInBlankQuestions();
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

    processQuestions();
    setupHints();
}

$(initialize);


