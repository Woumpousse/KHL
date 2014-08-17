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
        img.attr('src', iconName + '.png');
//        img.attr('width', 32);
        img.attr('height', 32);
        img.css('style', 'vertical-align: middle');
        img.css('display', 'display: inline-block');

        button.append(img);

        return button;
    }

    function createVerifyButton()
    {
        var button = createButton('verify');
        button.addClass('verify-control');
        button.attr('title', 'Verifieer');

        return button;
    }

    function createResetButton()
    {
        var button = createButton('reset');
        button.addClass('reset-control');
        button.attr('title', 'Reset');

        return button;
    }

    function createRevealButton()
    {
        var button = createButton('reveal');
        button.addClass('reveal-control');
        button.attr('title', 'Toon oplossing');

        return button;
    }

    function createHintButton()
    {
        var button = createButton('hint');
        button.addClass('hint-control');
        button.attr('title', 'Hint');

        return button;
    }

    return { createVerifyButton: createVerifyButton,
             createResetButton: createResetButton,
             createRevealButton: createRevealButton,
             createHintButton: createHintButton
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

                var box = newElement('div');
                box.addClass('question-control-box');

                question.prepend(box);
            } );
        }

        function findQuestionControlBox(question)
        {
            var result = question.find(".question-control-box").first();

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
            return $('[data-slideshow]');
        }

        function processSlideshow(slideshow)
        {
            function imageFilenamesFromPattern(filenamePattern)
            {
                var regex = /^(.*)\[(\d+)-(\d+)\](.*)$/;
                var match = regex.exec(filenamePattern);

                if ( !match )
                {
                    console.log("Failed to recognize pattern in " + filenamePattern);
                    throw "Slideshow pattern error";
                }
                else
                {
                    var prefix = match[1];
                    var from = parseInt(match[2]);
                    var to = parseInt(match[3]);
                    var postfix = match[4];
                    var result = [];

                    for ( var i = from; i <= to; ++i )
                    {
                        result.push( prefix + i + postfix );
                    }

                    return result;
                }
            }

            function createImageElement(filename)
            {
                var img = newElement('img');
                img.attr('src', filename);

                return img;
            }

            function findImages()
            {
                return slideshow.find('img');
            }

            function showImage(index)
            {
                var images = findImages();

                for ( var i = 0; i !== images.length; ++i )
                {
                    var image = $(images.get(i));

                    if ( i === index )
                    {
                        image.show();
                    }
                    else
                    {
                        image.hide();
                    }
                }
            }

            function createImageElements()
            {
                var pattern = slideshow.attr('data-slideshow');
                var imageFilenames = imageFilenamesFromPattern(pattern);

                for ( var i = 0; i !== imageFilenames.length; ++i )
                {
                    var imageFilename = imageFilenames[i];
                    
                    var img = createImageElement(imageFilename);
                    slideshow.append(img);
                }

                showImage(0);
            }

            function createNavigationButtons()
            {
                
                
            }

            createImageElements();
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
