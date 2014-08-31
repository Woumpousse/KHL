require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Variables < Controller
  def template(n)
    <<-END.unindent
      <h2>Oefening #{n}</h2>
      <div data-question="fill-in-blanks">
        <p>
          Geef aan welke waarden in de volgende variabele(n) bewaard zijn na uitvoering:
        </p>
        <pre><%= ex#{n}.code %></pre>
        <%= HTML::output_sheet( ex#{n}.output_map ) %>
      </div>
    </section>
    END
  end

  def ex1
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 1;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex2
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 4 * 5 + 6;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex3
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 10 % 3;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex4
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 5;
        var x = x * 2;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex5
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 5;
        var y = x + 2;
        x = 3;

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', x);`
      END
    end
  end

  def ex6
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 6;
        x *= 4;
        x -= 2;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex7
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 6;
        x++;

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex8
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 0;
        var y = 1;
        var z = 2;

        x += y;
        y *= z;
        z /= x;

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', y);`
        `hide:console.log('z=%d\n', z);`
      END
    end
  end
end
