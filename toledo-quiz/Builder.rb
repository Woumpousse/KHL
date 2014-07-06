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

  def add_question
    @@questions << Questions.parse_hash(@@hash)
  end

  def true_or_false(text, answer)
    scope do
      set('question class', Questions::TrueFalseQuestion)
      set('text', text)
      set('answer', answer)

      add_question
    end
  end

  def questions
    @@questions
  end
end
