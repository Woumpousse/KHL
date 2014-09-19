require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller
  def template(n)
    <<-END.unindent
      <h2>Oefening #{n}</h2>
      <div data-question="fill-in-blanks">
        <p>
          Geef aan welke waarden in de volgende variabele(n) bewaard zijn na uitvoering:
        </p>
        <pre><%= ex#{n}.code %></pre>
        <%= HTML::output_sheet( ex#{n}.output_map ) %>
        <%= generate_hint(ex#{n}) %>       
      </div>
    </section>
    END
  end

  def generate_hint(exercise)
    if exercise.hint?
    then
      hint = exercise.hint
      <<-END
        <div class="hint">
          #{hint}
        </div>
      END
    else
      ""
    end
  end

  def ex1
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 1;
        var y;

        if ( x >= 0 ) {
          y = 1;
        }
        else {
          y = 2;
        }

        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex2
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 1;
        var y = 5;

        if ( x - 2 > 0 ) {
          y = 1;
        }

        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex3
    once(__method__) do
      q = Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 3;
        var y;

        if ( x > 0 ) {
          y = 1;
        }
        else if ( x > 2 ) {
          y = 2;
        }
        else {
          y = 3;
        }

        `hide:console.log('y=%d\n', y);`
      END

      q.hint = <<-END.unindent
        <p>
          We hebben hier te maken met 3 mogelijke paden.
        </p>
        <img src="ex3.png" width="80%" class="center"></img>
        <p>
          Enkel het eerste pad waarvoor de conditie <code>true</code> oplevert
          wordt uitgevoerd: vanaf dat er een test slaagt, worden alle volgende
          paden genegeerd.
        </p>
      END

      q
    end
  end

  def ex4
    once(__method__) do
      q = Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 3;
        var y;

        if ( x > 0 ) {
          y = 1;
        }
        if ( x > 2 ) {
          y = 2;
        }
        else {
          y = 3;
        }

        `hide:console.log('y=%d\n', y);`
      END

      q.hint = <<-END.unindent
        <p>
          Merk op dat de tweede <code>if</code> geen <code>else</code> bevat.
          We hebben dus niet te maken met &eacute;&eacute;n splitsing in drie paden,
          maar met twee op elkaar volgende splitsingen met elk twee paden.
        </p>
        <img src="ex4.png" width="80%" class="center"></img>
        <p>
          Eerst wordt nagegaan of <code>x &gt; 0</code>; dit is het geval en
          <code>y = 1</code> wordt uitgevoerd. Omdat er geen <code>else</code>
          staat, is de volgende uit te voeren statement <code>if ( x &gt; 2 ) ...</code>
          Vermits <code>y &gt; 2</code>, wordt <code>y = 2</code> uitgevoerd.
          De <code>y = 3</code> staat in de <code>else</code>-branch:
          deze statement wordt overgeslagen.
        </p>
      END

      q
    end
  end

  def ex5
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 8;
        var y = 3;
 
        if ( x > y && 2 <= y ) {
          x = 1;
          y = 2;
        }
        else if ( x === 1 && y === 2 ) {
          x = 8;
          y = 9;
        }

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex6
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 8;
        var y = 3;
 
        if ( x > y ) {
          if ( 2 <= y ) {
            x = 1;
            y = 2;
          }
        }
        else if ( x === 1 ) {
          if ( y === 2 ) {
            x = 8;
            y = 9;
          }
        }

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex7
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 8;
        var y = 3;
 
        if ( x > y ) {
          if ( 2 <= y ) {
            x = 1;
            y = 2;
          }
        }
        if ( x === 1 ) {
          if ( y === 2 ) {
            x = 8;
            y = 9;
          }
        }

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', y);`
      END
    end
  end

  def ex8
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x;

        if ( true ) {
          x = 1;
        }
        else {
          x = 2;
        }

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex9
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x;

        if ( true && false ) {
          x = 1;
        }
        else {
          x = 2;
        }

        `hide:console.log('x=%d\n', x);`
      END
    end
  end

  def ex10
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 0;

        if ( x % 5 === 0 ) { x += 5; }
        if ( x < 3 ) { x *= 2; }
        if ( x > 3 && x < 7 ) { x--; }
        if ( x * x < 10 ) { x = 0; }

        `hide:console.log('x=%d\n', x);`
      END
    end
  end
end
