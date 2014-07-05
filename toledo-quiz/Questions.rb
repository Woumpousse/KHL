require './Types.rb'

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
    def initialize()
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
      ([ TOLEDO_PREFIX, text ] + @answers).join("\t")
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
    def initialize(text, pairs)
      Types.check(binding, {
                    'text' => String,
                    'pairs' => [ [String,String] ]
                  } )

      @text, @pairs = text, pairs
    end

    def toledo
      pairs = @pairs.map { |pair| pair.join("\t") }.join("\t\t")

      "FIB_PLUS\t#{text}\t#{pairs}"
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
    def initialize(text, pairs)
      Types.check(binding, {
                    'text' => String,
                    'pairs' => [ [String,Bool] ]
                  } )

      @text, @pairs = text, pairs
    end

    def toledo
      pairs = @pairs.map do |answer, truth|
        t = if truth then "correct" else "incorrect" end
        "#{answer}\t#{t}"
      end.join("\t")

      "MA\t#{text}\t#{pairs}"
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
q = MultipleFillInQuestion.new("x", [ ["T1", "5"] ])
puts q
