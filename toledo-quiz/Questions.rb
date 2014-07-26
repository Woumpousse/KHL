require './Types.rb'
require './Shared.rb'
require './Toledo.rb'
require './Java.rb'

module Questions
  class Question
    def initialize(text)
      Types.check( binding, {
                     'text' => String
                   } )

      @text = text
    end

    def check
    end

    attr_accessor :text, :toledo_text, :category, :difficulty, :template
  end

  class FillInQuestion < Question
    def initialize(text)
      Types.check( binding, {
                     'text' => String
                   } )

      super(text)

      @answer_groups = []
    end

    def add_answer_group(variable, possible_answers)
      Types.check( binding, {
                     'variable' => String,
                     'possible_answers' => [String]
                   } )

      @answer_groups << [ variable, possible_answers ]
    end

    def toledo
      if @answer_groups.length == 1
      then
        question = Toledo::SingleFillInQuestion( toledo_text )

        @answer_groups.each do |variable, possible_answers|
          possible_answers.each do |possible_answer|
            question.add_possible_answer(possible_answer)
          end
        end
      else
        question = Toledo::MultipleFillInQuestion( toledo_text )

        @answer_groups.each do |variable, possible_answers|
          question.add_answer_group(variable, possible_answers)
        end
      end        

      question.to_s
    end
  end

  #
  # TrueFalseQuestion
  #
  class TrueFalseQuestion < Question
    def initialize(text, answer)
      Types.check(binding, {
                    'text' => String,
                    'answer' => Types.one_of(true, false)
                  } )

      super(text)

      @answer = answer
    end

    attr_accessor :answer

    def toledo
      Toledo::TrueFalseQuestion.new( toledo_text, answer ).to_s
    end

    attr_accessor :text, :answer
  end


  #
  # MultipleAnswerQuestion
  #
  class MultipleAnswerQuestion < Question
    def initialize(text)
      Types.check(binding, {
                    'text' => String,
                  } )

      super(text)

      @claims = []
    end

    def add_claim(claim, answer)
      Types.check( binding, {
                     'claim' => String,
                     'answer' => Types.one_of( true, false )
                   } )
      
      @claims << [ claim, answer ]
    end

    def toledo
      question = Toledo::MultipleAnswerQuestion.new(toledo_text)

      @claims.each do |claim, answer|
        question.add_claim(claim, answer)
      end

      question.to_s
    end
  end


  #
  # NumericQuestion
  #
  class NumericQuestion < Question
    NAME = 'NUMERIC'

    def initialize(text, answer, delta)
      Types.check(binding, {
                    'text' => String,
                    'answer' => Fixnum,
                    'delta' => Fixnum
                  } )

      super(text)

      @answer = answer
      @delta = delta
    end

    attr_accessor :answer, :delta

    def toledo
      question = Toledo::NumericQuestion.new(toledo_text, answer, delta)

      question.to_s
    end
  end


  #
  # CodeFillInQuestion
  #
  class CodeFillInQuestion < Question
    PLACEHOLDER_REGEX = /__(.*?)__/
    
    def initialize(text, code_template)
      Types.check(binding, {
                    'text' => String,
                    'code_template' => String
                  } )
      
      super(text)

      @code_template = code_template
      @variable_name = lambda { |index| "x#{index}" }
    end

    attr_accessor :variable_name, :code_template

    def check
      translate_to_java.each do |code|
        Java.compile(Java.split_in_files(code))
      end
    end

    def toledo
      if single_placeholder?
      then toledo_single_placeholder
      else toledo_multiple_placeholders
      end
    end

    def texified_code
      if single_placeholder? then
        translate_to_tex_single_placeholder
      else
        translate_to_tex_multiple_placeholder
      end
    end

    private
    def toledo_single_placeholder
      answer_groups = find_answer_groups
      abort "Bug" unless answer_groups.length == 1
      answers = answer_groups[0]
      
      question = Toledo::SingleFillInQuestion.new(toledo_text)

      answers.each do |answer|
        question.add_possible_answer(answer)
      end

      question.to_s
    end

    def toledo_multiple_placeholders
      answer_groups = find_answer_groups
      abort "Bug" unless answer_groups.length > 1

      Types.check(binding, {
                    'answer_groups' => [[String]]
                  } )
      
      question = Toledo::MultipleFillInQuestion.new(toledo_text)

      answer_groups.each_with_index do |answer_group, index|
        question.add_answer_group( variable_name(index+1), answer_group )
      end

      question.to_s
    end

    def variable_name(index)
      Types.check( binding, {
                     'index' => Fixnum
                   } )

      @variable_name[index]
    end
    
    def find_answer_groups
      @code_template.scan(PLACEHOLDER_REGEX).each do |match_array|
        match = match_array[0]
        match.split('|').map { |x| x.strip }
      end
    end

    def translate_to_java
      expand_placeholders(replace_ellipses(@code_template.strip))
    end

    def replace_ellipses(code)
      code.gsub(/\.\.\./, 'throw new RuntimeException();')
    end

    def expand_placeholders(code)
      if code =~ PLACEHOLDER_REGEX then
        pre, match, post = $`, $1, $'
        match.split("|").map do |alternative|
          expand_placeholders("#{pre}#{alternative}#{post}")
        end.flatten
      else
        [ code ]
      end
    end

    def translate_to_tex_single_placeholder
      @code_template.gsub(PLACEHOLDER_REGEX) do
        '`\placeholder`'
      end.gsub(/\.\.\./) do
        '`\dots`'
      end
    end

    def translate_to_tex_multiple_placeholder
      k = 0
      @code_template.gsub(PLACEHOLDER_REGEX) do
        k += 1
        "`\\placeholdern{#{k}}`"
      end
    end

    def placeholder_count
      @code_template.scan(PLACEHOLDER_REGEX).length
    end

    def single_placeholder?
      placeholder_count == 1
    end
  end


  class InterpretCodeQuestion < Question
    def initialize(text, code)
      Types.check(binding, {
                    'text' => String,
                    'code' => String
                  } )

      super(text)

      @code = code
      @output = Lazy.new do
        classes = Java.split_in_files(code)
        Java.execute(classes)
      end
    end

    def check
      classes = Java.split_in_files(code)
      Java.compile(classes)
    end

    def toledo
      question = Toledo.SingleFillInQuestion(toledo_text)
      question.add_possible_answer(@output.value)
      question.to_s
    end

    def texified_code
      @code
    end
  end
end
