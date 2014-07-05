module LaTeX
  def self.generate(questions, template)
    template.gsub(/#QUESTIONS(.*?)#END/m) do
      question_template = $1
      questions.map do |question|
        question_template.gsub(/#TEXT/) do 
          question.text.strip
        end
      end.join("\n")
    end.gsub(/#ANSWERS(.*?)#END/m) do
      answer_template = $1.strip
      questions.map do |question|
        answer_template.gsub(/#TEXT/) do
          abort "Only one answer supported" unless question.answers.length == 1
          question.answers[0].strip
        end
      end.join("\n")
    end
  end
end
