require './Shared.rb'
require './Java.rb'
require './Toledo.rb'

class Question
  def initialize(code)
    @code = code
  end

  def output
    bundle = Java::Bundle.from_string(@code)
    Java::run(bundle)
  end

  attr_reader :code
end


$questions = []

def question
  code = yield

  $questions.push( Question.new(code) )
end

def latexify
  IO.read('exercises.template').gsub('%GSUB%') do
    $questions.map do |question|
      "\\begin{lstlisting}\n#{question.code.strip}\n\\end{lstlisting}\\clearpage"
    end.join("\n\n")
  end
end

def toledify(url_template)
  $questions.zip(1..$questions.length).map do |question, index|
    url = sprintf(url_template, index)

    q = Toledo::SingleFillInQuestion.new("<img src=\"#{url}\"></img>")
    q.add_possible_answer(question.output)
    q
  end
end

IO.read('exercises.java').split(%r{// -{3,}}).each do |code|
  question do
    code
  end
end

case ARGV[0]
when 'latex'
then puts latexify
when 'toledo'
then puts(toledify ARGV[1])
end
