require './Types.rb'
require './Shared.rb'


module Toledo
  class Question
    protected
    def join(fields)
      fields.join("\t")
    end
  end

  class SingleFillInQuestion < Question
    PREFIX = 'FIB'
    
    def initialize(text)
      Types.check( binding, {
                     'text' => String
                   } )

      @text = text
      @answers = []
    end

    def add_possible_answer(answer)
      @answers << answer
    end

    def to_s
      join( [ PREFIX, @text ] + @answers )
    end
  end

  class MultipleFillInQuestion < Question
    PREFIX = 'FIB_PLUS'

    def initialize(text)
      Types.check( binding, {
                     'text' => String,                     
                   } )

      @text = text
      @answers = []
    end

    def add_answer_group(variable, possible_answers)
      Types.check( binding, {
                     'variable' => String,
                     'possible_answers' => [String]
                   } )

      @answers << [ variable, possible_answers ]
    end

    def to_s
      answers = @answers.intersperse([[]]).flatten(1)

      join( [PREFIX, @text ] + answers )
    end
  end

  class MultipleAnswerQuestion < Question
    PREFIX = 'MA'

    def initialize(text)
      Types.check(binding, {
                    'text' => String
                  })

      @text = text
      @answers = []
    end

    def add_claim(claim, answer)
      Types.check( binding, {
                     'claim' => String,
                     'answer' => Types.one_of( true, false )
                   } )

      @answers << [ claim, answer ]
    end

    def to_s
      answers = @answers.map do |claim, answer|
        [ claim, if answer then "correct" else "incorrect" end ]
      end.flatten(1)

      join([PREFIX, @text ] + answers)
    end
  end

  class TrueFalseQuestion < Question
    PREFIX = 'TF'

    def initialize(text, answer)
      Types.check( binding, {
                     'text' => String,
                     'answer' => Types.one_of(true, false)
                   } )

      @text = text
      @answer = answer
    end

    def to_s
      answer = if @answer then "waar" else "onwaar" end

      join([PREFIX, @text, answer])
    end
  end

  class NumericQuestion < Question
    PREFIX = 'NUM'

    def initialize(text, answer, delta = 0)
      Types.check( binding, {
                     'text' => String,
                     'answer' => Fixnum,
                     'delta' => Fixnum
                   } )

      @text = text
      @answer = answer
      @delta = delta
    end

    def to_s
      join( [ PREFIX, @text, @answer, @delta ] )
    end
  end

  def Toledo.generate(questions)
    questions.each_with_index.map do |question, index|
      question.toledo_text = yield index
      question.toledo
    end.join("\n")
  end
end

