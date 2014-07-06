module LaTeX
  def self.generate(questions, template)
    template.gsub(/#QUESTION(.*?)#END/m) do
      question_template = $1
      questions.map do |question|
        question_template.gsub(/#\[(.*?)\]/) do 
          question.public_send($1.to_sym)
        end
      end.join("\n")
    end
  end
end
