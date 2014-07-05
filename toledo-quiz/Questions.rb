require './Types.rb'

module Questions

  class FillInQuestion
    def initialize(text, answers)
      Types.check(binding, {
                    'text' => String,
                    'answers' => [String]
                  } )


      @text, @answers = text, answers
    end

    def toledo(text)
      ([ "FIB", text ] + @answers).join("\t")
    end

    def to_s
      <<END
FillInQuestion
Text:
#{@text}
Answers:
#{@answers.join("\n")}
---
END
    end

    attr_reader :text, :answers
  end


  class MultipleFillInQuestion
    def initialize(text, pairs)
      @text, @pairs = text, pairs
    end

    def toledo(text)
      pairs = @pairs.map { |pair| pair.join("\t") }.join("\t\t")

      "FIB_PLUS\t#{text}\t#{pairs}"
    end

    def to_s
      <<END
MultipleFillInQuestion
Text:
#{@text}
Question/Answer Pairs:
#{@pairs.map {|x| x.join(":")}.join("\n")}
---
END
    end

    attr_reader :text, :answers
  end


  class MultipleAnswerQuestion
    def initialize(text, pairs)
      @text, @pairs = text, pairs
    end

    def toledo(text)
      pairs = @pairs.map do |answer, truth|
        t = if truth then "correct" else "incorrect" end
        "#{answer}\t#{t}"
      end.join("\t")

      "MA\t#{text}\t#{pairs}"
    end

    def to_s
      <<END
MultipleAnswerQuestion
Text:
#{@text}
Question/Answer Pairs:
#{@pairs.map {|x| x.join(":")}.join("\n")}
---
END
    end

    attr_reader :text, :answers
  end

end


