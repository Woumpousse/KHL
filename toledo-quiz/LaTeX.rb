module LaTeX
  def self.generate(questions, template)
    template.gsub(/#QUESTIONS(.*?)#ENDQUESTIONS/m) do
      data = $1

      templates = Hash[data.scan(/#TEMPLATE\[(.*?)\](.*?)#ENDTEMPLATE/m)]

      questions.map do |question|
        templates[question.template].gsub(/#\[(.*?)\]/) do 
          question.public_send($1.to_sym)
        end
      end.join
    end
  end
end
