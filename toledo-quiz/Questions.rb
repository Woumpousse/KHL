require './Types.rb'

module Enumerable
  def intersperse(item)
    map do |elt|
      [ item, elt ]
    end.flatten(1).drop(1)
  end
end

class String
  def unindent
    indentation = lines.map do |line|
      line =~ /^( *)/
      $1.length
    end.min

    lines.map do |line|
      line[indentation..-1]
    end.join
  end
end

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

    attr_reader :text, :answers
  end

end

include Questions
q1 = MultipleFillInQuestion.new("x", [ ["T1", "5"], ["T2", "8"] ])
q2 = MultipleAnswerQuestion.new("?", [ ["x", true], ["y", false] ])
puts q2.toledo
