require './Types.rb'
require './Shared.rb'

module Questions
  class Question
    def initialize(text)
      Types.check( binding, {
                     'text' => String
                   } )

      @text = text
    end

    def check
      []
    end

    attr_accessor :text, :toledo_text, :category, :difficulty
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
      Toledo::TrueFalseQuestion.new( self[:text], self[:answer] ).to_s
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
      question = Toledo::MultipleAnswerQuestion.new(@text)

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
      question = Toledo::NumericQuestion.new(@text, @answer, @delta)

      question.to_s
    end
  end


  class CodeFillInQuestion < Question
    PLACEHOLDER_REGEX = /__(.*?)__/
    
    def initialize(text, template)
      Types.check(binding, {
                    'text' => String,
                    'template' => String } )
      
      super(text)

      @template = template
      @variable_name = lambda { |index| "x#{index}" }
    end

    attr_accessor :template, :variable_name

    def check
      begin
        Java.compiles?(Java.split_in_files(@template))
        nil
      rescue Java::CompilationError => e
        e.to_s
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
      answers_groups = find_answer_groups
      abort "Bug" unless answer_groups.length > 1

      Types.check(binding, {
                    'answer_groups' => [[String]]
                  } )
      
      question = Toledo::MultipleFillInQuestion.new(toledo_text)

      answer_groups.each_with_index do |answer_group, index|
        question.add_answer_group( variable_name(index+1), answer)
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
      @template.scan(PLACEHOLDER_REGEX).each do |match_array|
        match = match_array[0]
        match.split('|').map { |x| x.strip }
      end
    end

    def translate_to_java
      code = @template.gsub(PLACEHOLDER_REGEX) do
        $1
      end.gsub(/\.\.\./, 'throw new RuntimeException();').strip
    end

    def translate_to_tex_single_placeholder
      @template.gsub(PLACEHOLDER_REGEX) do
        '`\placeholder`'
      end.gsub(/\.\.\./) do
        '`\dots`'
      end
    end

    def translate_to_tex_multiple_placeholder
      k = 0
      @template.gsub(PLACEHOLDER_REGEX) do
        "`\\placeholdern{#{k}}`"
        k += 1
      end
    end

    def placeholder_count
      @template.scan(PLACEHOLDER_REGEX).length
    end

    def single_placeholder?
      placeholder_count == 1
    end
  end
end
