

function newElement(tag)
{
    return $(document.createElement(tag));
}

var buttons = ( function () {
    function createButton(iconName)
    {
        var button = newElement('div');
        button.addClass("control-button");
        button.css('width', '32px');
        button.css('height', '32px');

        var img = newElement('img');
        img.attr('src', iconName + '.png');
        img.addClass('control');

        button.append(img);

        return button;
    }

    function createVerifyButton()
    {
        var button = createButton('verify');
        button.addClass('question-control');
        button.addClass('verify-control');
        button.attr('title', 'Verifieer');

        return button;
    }

    function createResetButton()
    {
        var button = createButton('reset');
        button.addClass('question-control');
        button.addClass('reset-control');
        button.attr('title', 'Reset');

        return button;
    }

    function createRevealButton()
    {
        var button = createButton('reveal');
        button.addClass('question-control');
        button.addClass('reveal-control');
        button.attr('title', 'Toon oplossing');

        return button;
    }

    function createHintButton()
    {
        var button = createButton('hint');
        button.addClass('question-control');
        button.addClass('hint-control');
        button.attr('title', 'Hint');

        return button;
    }

    function createPreviousButton()
    {
        var button = createButton('previous');
        button.addClass('previous-control');
        button.attr('title', 'Vorige');

        return button;
    }

    function createNextButton()
    {
        var button = createButton('next');
        button.addClass('next-control');
        button.attr('title', 'Volgende');

        return button;
    }

    return { createVerifyButton: createVerifyButton,
             createResetButton: createResetButton,
             createRevealButton: createRevealButton,
             createHintButton: createHintButton,
             createPreviousButton: createPreviousButton,
             createNextButton: createNextButton,
           };
} )();

function initialize()
{
    function findQuestions()
    {
        return $('[data-question]');
    }

    function addControlBox(receiver)
    {
        var box = newElement('div');
        box.addClass('control-box');
        
        receiver.prepend(box);

        return box;
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
                clearFeedback(element);
                
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

            function addQuestionControls()
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

                function addButtonsToControlBox(question)
                {
                    var box = findQuestionControlBox(question);

                    box.append( createVerifyButton(question) );
                    box.append( createResetButton(question) );
                    box.append( createSolutionButton(question) );
                }

                $('[data-question="selection"]').each( function () {
                    var question = $(this);

                    addButtonsToControlBox(question);
                } );
            }

            addSelectableHandlers();
            addQuestionControls();
        }

        function addClassToAllQuestions()
        {
            function assignClassToQuestion(element)
            {
                element.addClass('question');
            }

            findQuestions().each( function  () {
                var element = $(this);

                assignClassToQuestion(element);
            } );
        }

        function processFillInBlankQuestions()
        {
            function findInputs(question)
            {
                return question.find('input[data-solution]');
            }

            function hasCorrectInput(input)
            {
                var expected = input.attr('data-solution');
                var given = input.val();

                return expected === given;
            }

            function showFeedback(input)
            {
                if ( hasCorrectInput(input) ) {
                    input.addClass('correct');
                }
                else {
                    input.removeClass('correct');
                }
            }

            function showAllFeedback(question)
            {
                findInputs(question).each( function () {
                    var input = $(this);

                    showFeedback(input);
                } );
            }

            function clearInput(input)
            {
                input.val('');
            }

            function clearAllInputs(question)
            {
                findInputs(question).each( function () {
                    var input = $(this);

                    clearInput(input);
                } );
            }

            function clearFeedback(input)
            {
                input.removeClass('correct');
            }

            function clearAllFeedback(question)
            {
                findInputs(question).each( function () {
                    var input = $(this);

                    clearFeedback(input);
                } );
            }

            function addInputCheckers()
            {
                $('input').each( function () {
                    var input = $(this);

                    input.change( function () {
                        showFeedback(input);
                    } );
                } );
            }

            function revealSolution(input)
            {
                var solution = input.attr('data-solution');

                input.val(solution);
            }

            function revealAllSolutions(question)
            {
                question.find('input[data-solution]').each( function () {
                    var input = $(this);

                    revealSolution(input);
                } );
            }

            function addQuestionControls()
            {
                function createResetButton(question)
                {
                    function reset()
                    {
                        clearAllFeedback(question);
                        clearAllInputs(question);
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

                $('[data-question="fill-in-blanks"]').each( function () {
                    var question = $(this);
                    var controlBox = findQuestionControlBox(question);
                    
                    controlBox.append( createResetButton(question) );
                    controlBox.append( createSolutionButton(question) );
                } );
            }

            addInputCheckers();
            addQuestionControls();
        }

        function addControlBoxesToAllQuestions()
        {
            findQuestions().each( function () {
                var question = $(this);

                addControlBox(question);
            } );
        }

        function findQuestionControlBox(question)
        {
            var result = question.find(".control-box").first();

            if ( !result ) {
                console.log("Warning: no control box found for " + question.toString());
            }

            return result;
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
                function containsHintData(question)
                {
                    return question.find('.hint').length > 0;
                }

                function createHintButton(question)
                {
                    function showHint()
                    {
                        question.find('.hint').show();
                    }

                    var hintButton = buttons.createHintButton();
                    hintButton.click( showHint );
                    
                    return hintButton;
                }

                findQuestions().each( function () {
                    var question = $(this);                
                    var questionId = question.attr('id');

                    if ( containsHintData(question) )
                    {
                        var controlBox = findQuestionControlBox(question);
                        var hintButton = createHintButton(question);

                        controlBox.prepend(hintButton);
                    }
                } );
            }

            addHintButtons();
        }

        function formatCode()
        {
            $('pre').wrap( function() {
                return "<div class=\"code\"></div>";
            } );
        }

        addClassToAllQuestions();
        addControlBoxesToAllQuestions();
        formatCode();

        processSelectionQuestions();
        processFillInBlankQuestions();

        setupHints();
    }

    function processSlideshows()
    {
        function findSlideshows()
        {
            return $('.slideshow');
        }

        function processSlideshow(slideshow)
        {
            function findSlides()
            {
                return slideshow.find('.slide');
            }

            function numberSlides()
            {
                var slides = findSlides();

                for ( var i = 0; i !== slides.length; ++i )
                {
                    var slide = $(slides.get(i));
                    slide.attr('data-slide', i);
                }
            }

            function countSlides()
            {
                return findSlides().length;
            }

            function showSlide(indexOfSlideToShow)
            {
                var slides = findSlides();

                for ( var i = 0; i !== slides.length; ++i )
                {
                    var slide = $(slides.get(i));
                    var slideIndex = parseInt( slide.attr('data-slide') );

                    if ( slideIndex === indexOfSlideToShow )
                    {
                        slide.show();
                    }
                    else
                    {
                        slide.hide();
                    }
                }
            }

            function createNavigationButtons()
            {
                var currentSlide = 0;

                function showCurrentSlide()
                {
                    showSlide(currentSlide);
                }

                function disableButton(button)
                {
                    button.addClass('disabled');
                }

                function enableButton(button)
                {
                    button.removeClass('disabled');
                }

                function createPreviousAndNextButton()
                {
                    var previousButton = buttons.createPreviousButton();
                    var nextButton = buttons.createNextButton();
                    var maximumSlideIndex = countSlides() - 1;

                    function updateButtonStatus()
                    {
                        if ( currentSlide === 0 )
                        {
                            disableButton(previousButton);
                            enableButton(nextButton);
                        }
                        else if ( currentSlide === maximumSlideIndex )
                        {
                            enableButton(previousButton);
                            disableButton(nextButton);
                        }
                        else
                        {
                            enableButton(previousButton);
                            enableButton(nextButton);
                        }
                    }

                    function previous()
                    {
                        if ( currentSlide > 0 )
                        {
                            currentSlide--;
                            showCurrentSlide();
                        }

                        updateButtonStatus();
                    }

                    function next()
                    {
                        if ( currentSlide  < maximumSlideIndex )
                        {
                            currentSlide++;
                            showCurrentSlide();
                        }
                        
                        updateButtonStatus();
                    }

                    previousButton.click( previous );
                    nextButton.click( next );

                    updateButtonStatus();

                    return { previous: previousButton,
                             next: nextButton };
                }

                var box = addControlBox(slideshow);
                var navigationButtons = createPreviousAndNextButton();
                box.append( navigationButtons.previous );
                box.append( navigationButtons.next );
            }

            numberSlides();
            showSlide(0);
            createNavigationButtons();
        }

        findSlideshows().each( function () {
            var slideshow = $(this);

            processSlideshow(slideshow);
        } );
    }

    processQuestions();
    processSlideshows();
}

$(initialize);
