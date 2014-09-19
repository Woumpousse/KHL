require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller
  def interpret(code)
    question = Questions::JavaScript::InterpretCode.new.parse( code.unindent.strip )

    <<-END.unindent
      <section>
        <%= exercise_header %>
        <div data-question="fill-in-blanks">
          <p>
            Na uitvoering zijn de volgende variabelen gelijk aan:
          </p>
          <pre>#{question.code}</pre>
          #{HTML::output_sheet( question.output_map )}
        </div>
      </section>
    END
  end

  def multi_interpret(code, xs)
    question = Questions::JavaScript::InterpretCode.new.parse( code.unindent.strip )

    params = question.parameter_names
    abort "Need exactly one parameter, got #{params}" unless params.length == 1
    param = params[0]

    id = nil

    questions = xs.map do |x|
      output = question.output_map( { param => x } )

      abort "Need exactly one output parameter, got #{output}" unless output.size == 1
      pair = output.to_a[0]
      id, answer = pair[0], pair[1]

      "<li>Indien #{param} = <code>#{x}</code>, dan is <code>#{id} = </code>#{HTML::blank_inputbox(answer)}</li>"
    end.join("\n")

    <<-END.unindent
      <section>
        <%= exercise_header %>
        <div data-question="fill-in-blanks">
          <pre>#{question.code}</pre>
          <p>
            Wat is de waarde van <code>#{id}</code> na uitvoer indien deze deze <code>x</code>
            de volgende waarden aanneemt.
          </p>
          <ul>
            #{questions}
          </ul>
        </div>
      </section>
    END
  end
end
