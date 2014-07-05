module Toledo
  def self.generate(questions)
    questions.each_with_index.map do |question, index|
      text = yield index

      question.format(text)
    end.join("\n")
  end
end
