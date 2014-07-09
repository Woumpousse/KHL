require './Builder.rb'
require './LaTeX.rb'

include Builder

set('text', "")

in_category('verzamelingenleer') do
  difficulty('1') do
    scope do
      append('text', <<-END)
        Is deze uitspraak waar of vals?
      END

      # Propositions which are true
      <<-'END'.lines.map { |line| true_or_false("\\[ #{line.strip} \\]", true) }
        \emptyset \subset \emptyset
        \emptyset \subset \{ 1, 2, 3 \}
        \{ 1 \} \subset \{ 1, 2, 3 \}
        \{ 1, 2 \} = \{ 2, 1 \}
        \{ 1, 2 \} = \{ 1, 2, 1 \}
        \{ 1, 2, 2 \} \subset \{ 1, 2 \}
        \emptyset \subset \{ \emptyset \}
        \emptyset \in \{ \emptyset \}
        X \union X = X
        X \intersection X = X
        X - X = \emptyset
      END

      # Propositions which are false
      <<-'END'.lines.map { |line| true_or_false("\\[ #{line.strip} \\]", false) }
        \emptyset = \{ 1, 2, 3 \}
        \emptyset \in \{ 1, 2, 3 \}
        1 \subset \{ 1, 2, 3 \}
        1 = \{ 1 \}
        \emptyset = \{ \emptyset \}
        X \intersection X = \emptyset
      END
    end
  end

  difficulty('2') do
    scope do
      append('text', <<-END)
        Is deze uitspraak waar of vals?
      END

      # Propositions which are true
      <<-'END'.lines.map { |line| true_or_false("\\[ #{line.strip} \\]", true) }
        (A \union B) - A = A - (A \intersection B)
        A \intersection (B \union A) = A
      END

      # Propositions which are false
      <<-'END'.lines.map { |line| true_or_false("\\[ #{line.strip} \\]", false) }
        (A \union B) \intersection C = A \union (B \intersection C)
        (A \union B) - B = A
        (A \union B) - A = B
        A \intersection (B \union A) = A \intersection B
      END
    end
  end
end


puts tex(IO.read('wiskunde1.template.tex'))
