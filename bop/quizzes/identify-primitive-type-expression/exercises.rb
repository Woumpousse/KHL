require './Toledo.rb'

$questions = []

def type(t)
  literals = yield

  literals.each do |literal|
    q = Toledo::SingleFillInQuestion.new("Wat is het type van #{literal}?")
    q.add_possible_answer(t)

    $questions.push(q)
  end
end


type 'int' do
  <<-'END'.unindent.lines.map { |line| line.strip }
    10 / 2
    7 / 3
    5 % 3
    7 * (3 + 5) / 6
  END
end

type 'String' do
  <<-'END'.unindent.lines.map { |line| line.strip }
    "" + "5"
    "" + 5
    "abc" + "def"
  END
end

type 'double' do
  <<-'END'.unindent.lines.map { |line| line.strip }
    1.0 * 5
    4.0 / 2.0
    9 * 3.0    
  END
end

type 'boolean' do
  <<-'END'.unindent.lines.map { |line| line.strip }
    2 < 3
    5.3 == 2.4
    7 != 9
  END
end


$questions.each do |q|
  puts q.to_s
end
