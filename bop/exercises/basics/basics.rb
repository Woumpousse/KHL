require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller
  def hello_world
    Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        __`class`__ HelloWorld
        {
            public static void __`main`__(String[] args)
            {
                System.out.__`println`__("__`Hello World`__");
            }
        }
    END
  end

  def types
    entries = <<-END.unindent
      5 : int
      "Hello" : String
      'f' : char
      -9 : int
      true : boolean
      0.5 : double
      "0" : String
      false : boolean
      '7' : char
      0.0 : double
    END

    entries = entries.lines.map do |entry|
      entry.split(':').map do |token|
        token.strip
      end
    end

    HTML::table( [ 'Literal', 'Type' ],
                 entries,
                 { 'class' => 'types-table' } ) do |literal, type|
      inputbox = HTML::blank_inputbox(type)
      
      HTML::tablerow([ "<code>#{literal}</code>", inputbox ])
    end
  end

  def course
    Questions::Java::AutoFillInTypes.new.parse( <<-'END'.unindent.strip )
        public class Vak
        {
            private String naam;
            private int aantalStudiepunten;
            private boolean tolereerbaar;
            private String omschrijving;
            private double urenLesPerWeek;
            private double urenOefeningenPerWeek;
        }
    END
  end
end
