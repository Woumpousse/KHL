module LaTeX
  def self.generate(questions, template)
    template.gsub(/#QUESTIONS(.*?)#END/m) do
      question_template = $1
      questions.map do |question|
        question_template.gsub(/#TEXT/) do 
          question.text.strip
        end
      end.join("\n")
    end
  end
end
