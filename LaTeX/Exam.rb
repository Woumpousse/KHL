require './MedicalDictionary.rb'
require './Questions.rb'
require './Shared.rb'


module Exam
  def self.build(&block)
    ExamBuilder.build(&block)
  end

  class ExamBuilder
    def self.build(&block)
      builder = ExamBuilder.new
      builder.instance_eval(&block)
      builder.finalize
      builder.result
    end

    def initialize
      @contents = <<-'END'.unindent
        \documentclass[a4paper]{khlexam}
        \usepackage{framed}
      END
    end

    def hoofding(&block)
      HeaderBuilder.build(self, &block)
    end

    def inhoud(&block)
      DocumentBuilder.build(self, &block)
    end

    def finalize
    end

    def result
      @contents
    end

    def append(data)
      @contents += data
    end
  end

  class HeaderBuilder
    def self.build(exam_builder, &block)
      builder = HeaderBuilder.new(exam_builder, &block)
      builder.instance_eval(&block)
      builder.finalize
    end

    def initialize(exam_builder)
      @exam_builder = exam_builder
    end

    def academiejaar(year)
      @academic_year = year
    end

    def datum(date)
      @date = date
    end

    def beginuur(start)
      @start = start
    end

    def finalize
      @exam_builder.append(<<-END.unindent)
         \\exam{
           academiejaar={#{@academic_year}},
           opleiding={Bachelor in de Voedings- en Dieetkunde},
           fase={1},
           examinator={S. Opsomer},
           opo={MDB23A -- Leven in beeld -- deel 1},
           ola={MDB23d -- Menselijke biologie},
           activiteit={Schriftelijk examen},
           hulpmiddelen={Geen},
           datum={#{@date}},
           beginuur={#{@start}},
           duur={3 uur}
         }
       END
    end
  end

  class DocumentBuilder
    def self.build(exam_builder, &block)
      builder = DocumentBuilder.new(exam_builder)
      builder.instance_eval(&block)
      builder.finalize
    end

    def initialize(exam_builder)
      @exam_builder = exam_builder

      @exam_builder.append(<<-'END'.unindent)
        \begin{document}
      END
    end

    def finalize
      @exam_builder.append(<<-'END'.unindent)
        \end{document}
      END
    end

    def richtlijnen
      @exam_builder.append(<<-'END'.unindent)
        \begin{center}
          \begin{minipage}{.9\linewidth}
            \begin{framed}
              Het examen ``menselijke biologie'' is een
              schriftelijk examen. Lees de vragen aandachtig
              en geef een gericht en gestructureerd antwoord
              op de gestelde vraag. Gebruik hiervoor
              enkel de voorziene antwoordruimte. Het is
              aangewezen je antwoord eerst op een kladblad
              te formuleren. Er mogen geen extra bladen
              worden toegevoegd. Alle kladbladen worden na
              afloop van het examen afgegeven aan de
              surveillant en maken geen deel uit van het examen.
              Ze worden dan ook nooit nagelezen of beoordeeld.
              \begin{center}
              Veel succes!
              \end{center}
            \end{framed}
          \end{minipage}
        \end{center}
      END
    end

    def terminologie(&block)
      MedicalTerminologyQuestionBuilder.build(@exam_builder, &block)
    end

    def vragen(n)
      Questions::questions.pick(n).each do |question|
        @exam_builder.append(question)
      end
    end
  end

  class MedicalTerminologyQuestionBuilder
    def self.build(exam_builder, &block)
      builder = MedicalTerminologyQuestionBuilder.new(exam_builder)
      builder.instance_eval(&block)
      builder.finalize
    end

    def initialize(exam_builder)
      @exam_builder = exam_builder

      @exam_builder.append(<<-'END'.unindent)
        \begin{question}
      END
    end

    def finalize
      @exam_builder.append(<<-'END'.unindent)
        \end{question}
      END
    end

    def latijn_ndl(n)
      @exam_builder.append(<<-'END'.unindent)
        \begin{minipage}{\linewidth}
        Geef de betekenis van volgende medische termen.
        Bij samengestelde woorden zorg je ervoor
        dat elk deel ``vertaald'' is tenzij de vertaling
        een enkelvoudige Nederlandse term is.
        Meervoudsvormen moeten ook als dusdanig vertaald worden.
        \vskip5mm
        \begin{center}
          \begin{tabular}{p{.33\linewidth}p{.50\linewidth}}
      END

      MedicalDictionary.entries.pick(n).each do |entry|
        @exam_builder.append(<<-END.unindent)
          #{entry[:latijn]} & \\hrulefill \\\\[4mm]
        END
      end

      @exam_builder.append(<<-'END'.unindent)
          \end{tabular}
        \end{center}
        \end{minipage}
      END
    end

    def ndl_latijn(n)
      @exam_builder.append(<<-'END'.unindent)
        \begin{minipage}{\linewidth}
        Geef de medische term voor
        \vskip5mm
        \begin{center}
          \begin{tabular}{p{.33\linewidth}p{.50\linewidth}}
      END

      MedicalDictionary.entries.pick(n).each do |entry|
        @exam_builder.append(<<-END.unindent)
          #{entry[:ndl]} & \\hrulefill \\\\[4mm]
        END
      end

      @exam_builder.append(<<-'END'.unindent)
          \end{tabular}
        \end{center}
        \end{minipage}
      END

    end
  end
end
