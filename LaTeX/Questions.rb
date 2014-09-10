require './Shared.rb'

module Questions
  @@questions = []

  def self.define(&block)
    @@questions = Builder.build(&block)
  end

  def self.questions
    @@questions
  end

  class Builder
    def self.build(&block)
      builder = Builder.new
      builder.instance_eval(&block)
      builder.result
    end

    def initialize
      @questions = []
    end

    def result
      @questions
    end

    def question
      txt = yield
    
      @questions.push(<<-END.unindent)
        \\begin{question}
        #{txt}
        \\end{question}
      END
    end
  end
end



Questions::define do
  question do
    <<-'END'.unindent
    Geef de kenmerken en eigenschappen van het hartspierweefsel.
    \vspace{8cm}
    END
  end

  question do
    <<-'END'.unindent
    Situeer de alveolocapillaire membraan binnen het orgaan waarin deze membraan voorkomt.
    \vspace{8cm}
    Beschrijf (microscopisch) deze alveolo-capillaire membraan.
    END
  end

  question do
    <<-'END'.unindent
    Vergelijk de microscopische bouw van de wand van de slokdarm met de basisbouw
    van de spijsverteringsbuis.
    \vspace{8cm}
    END
  end

  question do
    <<-'END'.unindent
    \raggedright Benoem de aangeduide structuren op volgende tekening:
    \figuur[height=8cm]{brain.png}
    \begin{center}
      \begin{tabular}{p{.4\linewidth}p{.4\linewidth}}
        1. \hrulefill & 2. \hrulefill \\[4mm]
        3. \hrulefill & 4. \hrulefill \\[4mm]
        5. \hrulefill & 6. \hrulefill \\[4mm]
        7. \hrulefill & 8. \hrulefill \\[4mm]
        9. \hrulefill & 10. \hrulefill \\[4mm]
        11. \hrulefill & 12. \hrulefill \\[4mm]
        13. \hrulefill & \\[4mm]
      \end{tabular}
    \end{center}
    END
  end

  question do
    <<-'END'.unindent
    \raggedright Benoem de aangeduide structuren op volgende tekening:
    \figuur[height=8cm]{resp.png}
    \begin{center}
      \begin{tabular}{p{.4\linewidth}p{.4\linewidth}}
        1. \hrulefill & 2. \hrulefill \\[4mm]
        3. \hrulefill & 4. \hrulefill \\[4mm]
        5. \hrulefill & 6. \hrulefill \\[4mm]
        7. \hrulefill & 8. \hrulefill \\[4mm]
        9. \hrulefill & 10. \hrulefill \\[4mm]
        11. \hrulefill
      \end{tabular}
    \end{center}
    END
  end
end
