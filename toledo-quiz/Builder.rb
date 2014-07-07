require './Shared.rb'
require './Questions.rb'

module Builder
  @@questions = []
  @@hash = Hash.new

  def scope
    begin
      old_hash = @@hash.clone
      yield
    ensure
      @@hash = old_hash
    end
  end

  def set(key, val)
    @@hash[key] = val
  end

  def append(key, val)
    @@hash[key] += val
  end

  def with(key, val)
    scope do
      set(key, val)
      yield
    end
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

  def add_question
    @@questions << Questions.parse_hash(@@hash)
  end

  def true_or_false(text, answer)
    scope do
      set('question class', Questions::TrueFalseQuestion)
      append('text', text.unindent)
      set('answer', answer)

      add_question
    end
  end

  def numeric(text, answer, delta=0)
    scope do
      set('question class', Questions::NumericQuestion)
      append('text', text.unindent)
      set('answer', answer)
      set('delta', delta)

      add_question
    end
  end

  def fillin(text, answer)
    scope do
      set('question class', Questions::FillInQuestion)
      append('text', text.unindent)
      set('answer', answer)

      add_question
    end
  end

  def questions
    @@questions
  end

  def tex(template)
    LaTeX.generate(questions, template)
  end
end
