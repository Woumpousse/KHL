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
  [0,-1,1,546].map do |n|
    n.to_s
  end
end

type 'char' do
  "ax0 *.?%".split(//).map do |c|
    "'#{c}'"
  end
end

type 'String' do
  [ "", "a", " ", "45", "-1", "Hello" ].map do |s|
    "\"#{s}\""
  end
end

type 'double' do
  [ "0.0", "1.5", "3.1415" ]
end

type 'boolean' do
  [ "true", "false" ]
end


$questions.each do |q|
  puts q.to_s
end
