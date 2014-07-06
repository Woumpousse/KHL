require './Builder.rb'
require './LaTeX.rb'

include Builder

in_category('verzamelingenleer') do
  true_or_false(<<-'END', true)
    \[
      \emptyset \subset \emptyset
    \]
  END

  true_or_false(<<-'END', true)
    \[
      \emptyset \subset \{ 1, 2, 3 \}
    \]
  END

  true_or_false(<<-'END', true)
    \[
      \{ 1 \} \subset \{ 1, 2, 3 \}
    \]
  END

  true_or_false(<<-'END', false)
    \[
      1 \subset \{ 1, 2, 3 \}
    \]
  END
end


puts LaTeX.generate(questions, IO.read('template.tex'))
