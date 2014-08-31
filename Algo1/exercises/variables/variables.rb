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

        var y = 6;
        y++;

        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex7
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

  def ex8
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var a = true;
        var b = false;
        var c = a || b;
        var d = a && b;
        var e = !a;

        `hide:console.log('a=%s\n', a ? 'true' : 'false');`
        `hide:console.log('b=%s\n', b ? 'true' : 'false');`
        `hide:console.log('c=%s\n', c ? 'true' : 'false');`
        `hide:console.log('d=%s\n', d ? 'true' : 'false');`
        `hide:console.log('e=%s\n', e ? 'true' : 'false');`
      END
    end
  end

  def ex9
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var a = 5;
        var b = 8;
        var c = a < b;
        var d = b !== 8;
        var e = c || d || (123+456*987 === 444 + 561 * 2);

        `hide:console.log('a=%d\n', a);`
        `hide:console.log('b=%d\n', b);`
        `hide:console.log('c=%s\n', c ? 'true' : 'false');`
        `hide:console.log('d=%s\n', d ? 'true' : 'false');`
        `hide:console.log('e=%s\n', e ? 'true' : 'false');`
      END
    end
  end

  def ex10
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var a = 5
        var b = true;
        var c = "abc";
        var d = a === b;
        var e = b !== c;

        `hide:console.log('a=%d\n', a);`
        `hide:console.log('b=%d\n', b);`
        `hide:console.log('c=%s\n', c);`
        `hide:console.log('d=%s\n', d ? 'true' : 'false');`
        `hide:console.log('e=%s\n', e ? 'true' : 'false');`
      END
    end
  end
end
