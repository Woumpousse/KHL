require './Types.rb'
require './Shared.rb'

module Questions

  class Question
    protected
    def format_toledo(prefix, fields)
      ([prefix] + fields).join("\t")
    end
  end


  #
  # FillInQuestion
  #
  class FillInQuestion < Question
    TOLEDO_PREFIX = 'FIB'
    NAME = 'FILLIN'

    def initialize(text, answers)
      Types.check(binding, {
                    'text' => String,
                    'answers' => [String]
                  } )


      @text, @answers = text, answers
    end

    def toledo
      format_toledo(TOLEDO_PREFIX, [text] + @answers)
    end

    def to_s
      <<-END.unindent
      FillInQuestion
        Text:
        #{@text}
        Answers:
        #{@answers.join("\n")}
      END
    end

    attr_reader :text, :answers
  end



  #
  # MultipleFillInQuestion
  #
  class MultipleFillInQuestion < Question
    TOLEDO_PREFIX = 'FIB_PLUS'
    NAME = 'MULTIFILLIN'

    def initialize(text, pairs)
      Types.check(binding, {
                    'text' => String,
                    'pairs' => [ [String,String] ]
                  } )

      @text, @pairs = text, pairs
    end

    def toledo
      answers = @pairs.intersperse([""]).flatten

      format_toledo(TOLEDO_PREFIX, [text] + answers)
    end

    def to_s
      <<-END.unindent
      MultipleFillInQuestion
        Text:
        #{@text}
        Question/Answer Pairs:
        #{@pairs.map {|x| x.join(":")}.join("\n")}
      END
    end

    attr_reader :text, :answers
  end



  #
  # MultipleAnswerQuestion
  #
  class MultipleAnswerQuestion < Question
    TOLEDO_PREFIX = 'MA'
    NAME = 'MULTIPLE ANSWER'

    def initialize(text, pairs)
      Types.check(binding, {
                    'text' => String,
                    'pairs' => [ [String, Types.one_of(true, false)] ]
                  } )

      @text, @pairs = text, pairs
    end

    def toledo
      pairs = @pairs.map do |answer, truth|
        [ answer, if truth then "correct" else "incorrect" end ]
      end.flatten(1)

      format_toledo(TOLEDO_PREFIX, [ text ] + pairs)
    end

    def to_s
      <<-END.unindent
      MultipleAnswerQuestion
        Text:
        #{@text}
        Question/Answer Pairs:
        #{@pairs.map {|x| x.join(":")}.join("\n")}
      END
    end

    attr_reader :text, :pairs
  end


  #
  # TrueFalseQuestion
  #
  class TrueFalseQuestion < Question
    TOLEDO_PREFIX = 'TF'
    NAME = 'TRUE/FALSE'

    def self.parse_hash(hash)
      Types.check(binding, { 'hash' => Hash })

      text = hash['text']
      answer = hash['answer']

      Types.check(binding, {
                    'text' => String,
                    'answer' => Types.one_of(true, false)
                  })

      TrueFalseQuestion.new(text, answer)
    end

    def initialize(text, answer)
      Types.check(binding, {
                    'text' => String,
                    'answer' => Types.one_of(true, false)
                  } )

      @text, @answer = text, answer
    end

    def toledo
      format_toledo(TOLEDO_PREFIX, [ text, if @answer then "waar" else "onwaar" end ])
    end

    def to_s
      <<-END.unindent
TrueFalseQuestion
  Text:
#{@text.indent(4)}
  Answer:
    #{@answer}
      END
    end

    attr_reader :text, :answer
  end


  def Questions.question_classes
    Questions.classes.select do |c|
      c.constants.member?(:NAME)
    end
  end

  def Questions.class_with_name(name)
    Types.check(binding, { 'name' => String })

    result = question_classes.select do |c|
      c::NAME == name
    end

    raise "Unknown question type #{name}" unless result.length == 1

    result[0]
  end

  def Questions.parse_hash(hash)
    Types.check(binding, { 'hash' => Hash })

    question_class = hash['question class']

    if String === question_class then
      question_class = class_with_name(hash[:name])
    end

    question_class.parse_hash(hash)
  end
end
