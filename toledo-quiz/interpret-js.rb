require './JavaScript.rb'
require './Questions.rb'
require './Builder.rb'
require './Toledo.rb'

module JavaScript
  class InterpretQuestion < Questions::Question
    def initialize(text, code)
      Types.check(binding, {
                    'text' => String,
                    'code' => String
                  } )

      super(text)

      @code = code
      @output = Lazy.new do
        JavaScript.execute(@code).strip
      end
    end

    def check
      JavaScript.compile(@code)
    end

    def toledo
      question = Toledo::SingleFillInQuestion.new(toledo_text)
      question.add_possible_answer(@output.value)
      question.to_s
    end

    def texified_code
      @code
    end

    def output
      @output.value
    end
  end
end

include Builder


STDIN.read.split(/---/).map do |code|
  code.strip
end.select do |code|
  not code.empty?
end.each do |code|
  with('template', 'interpret') do
    question = JavaScript::InterpretQuestion.new("Wat is de uitvoer van volgende code?", code)
    add_question(question)
  end
end

set_toledo_text do |question, index|
  "Question #{index}"
end

case ARGV[0]
when "tex"
then puts tex(IO.read('algo1.template.tex'))
when "toledo"
then puts( toledo { |idx| to_s } )
else abort "Unrecognized command"
end
