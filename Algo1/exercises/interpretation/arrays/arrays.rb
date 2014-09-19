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
          #{HTML::output_sheet( question.output_map, 'ignore_whitespace' )}
        </div>
      </section>
    END
  end

  def multi_interpret(code, params, args)
    question = Questions::JavaScript::InterpretCode.new.parse( code.unindent.strip )

    output_var = nil

    questions = args.map do |vals|
      abort "Need as many arguments as there are parameters" unless params.length == vals.length

      formatted_parameter_bindings = params.zip(vals).map do |arg, val|
        "<code>#{arg} = #{val}</code>"
      end.join(", ")

      output = question.output_map( Hash[ params.zip(vals) ] )

      abort "Need exactly one output, got #{output}" unless output.size == 1
      pair = output.to_a[0]
      output_var, answer = pair[0], pair[1]

      "<li>Indien #{formatted_parameter_bindings}, dan is <code>#{output_var} = </code>#{HTML::blank_inputbox(answer, "", 'ignore_whitespace')}</li>"
    end.join("\n")

    <<-END.unindent
      <section>
        <%= exercise_header %>
        <div data-question="fill-in-blanks">
          <pre>#{question.code}</pre>
          <p>
            Wat is de waarde van <code>#{output_var}</code> na uitvoer indien deze variabelen volgende waarden aannemen:
          </p>
          <ul>
            #{questions}
          </ul>
        </div>
      </section>
    END
  end
end
