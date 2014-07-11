module LaTeX
  def self.generate(questions, template)
    template.gsub(/#QUESTIONS(.*?)#ENDQUESTIONS/m) do
      data = $1

      question_templates = Hash[data.scan(/#TEMPLATE\[(.*?)\](.*?)#ENDTEMPLATE/m)]

      questions.map do |question|
        question_template = question_templates[question.template]

        raise "No template found" unless question_template

        question_template.gsub(/#\[(.*?)\]/) do 
          question.public_send($1.to_sym)
        end
      end.join
    end
  end
end
