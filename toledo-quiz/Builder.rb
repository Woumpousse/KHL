require './Shared.rb'
require './Questions.rb'
require './LaTeX.rb'

module Builder
  @@questions = []
  @@postprocessor = lambda { |q| nil }

  def scope
    begin
      old_postprocessor = @@postprocessor
      yield
    ensure
      @@postprocessor = old_postprocessor
    end
  end

  def add_postprocessor
    old_postprocessor = @@postprocessor

    @@postprocessor = lambda do |question|
      yield question
      old_postprocessor[question]
    end
  end

  def set(key, val)
    add_postprocessor do |question|
      message = "#{key}=".to_sym

      question.send(message, val)
    end
  end

  def with(key, val)
    scope do
      set(key, val)

      yield
    end
  end

  def prepend(key, val)
    add_postprocessor do |question|
      read_message = key.to_sym
      write_message = "#{key}=".to_sym

      value = question.send(read_message)
      question.send(write_message, val + value)
    end

    yield
  end

  def in_category(category)
    with('category', category) do
      yield
    end
  end

  def difficulty(difficulty)
    with('difficulty', difficulty) do
      yield
    end
  end

  def add_question(question)
    @@postprocessor[question]
    @@questions << question
  end

  def true_or_false(text, answer)
    scope do
      question = Questions::TrueFalseQuestion.new(text, answer)

      add_question(question)
    end
  end

  def numeric(text, answer, delta=0)
    scope do
      question = Questions::NumericQuestion.new(text, answer, delta)

      add_question(question)
    end
  end

  def fill_in(text, *answer_groups)
    scope do
      question = Question.FillInQuestion.new(text)
      answer_groups.each do |answer_group|
        question.add_answer_group(answer_group)
      end

      add_question(question)
    end
  end

  def questions
    @@questions
  end

  def tex(template)
    LaTeX.generate(questions, template)
  end

  def set_toledo_text
    @@questions.each_with_index do |question, index|
      question.toledo_text = yield question, index
    end
  end

  def toledo
    @@questions.map do |question|
      question.toledo
    end.join("\n")
  end

  def check
    questions.each do |question|
      question.check
    end
  end
end
