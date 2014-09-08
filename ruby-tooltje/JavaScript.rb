require 'tmpdir.rb'
require 'open3'
require './Types.rb'

module JavaScript
  KEYWORDS = %w(break case class catch const continue debugger default delete
                do else export extends finally for function if import in
                instanceof let new return super switch this throw try typeof
                var void while with yield)

  FILE_NAME = 'temp.js'

  class JavaScriptError < StandardError
    def initialize(message)
      super(message)
    end
  end

  class RunError < JavaScriptError
    def initialize(message)
      super(message)
    end
  end

  def JavaScript.run(code)
    Types.check(binding, { 'code' => String })

    run_without_aux( aux_library + "\n" + code )
  end

  def JavaScript.run_without_aux(code)
    Types.check(binding, { 'code' => String })

    with_code_written_to_temporary_file(code) do |filename|
      JavaScript.invoke_interpreter(filename)
    end
  end

  def JavaScript.invoke_interpreter(file, path='.')
    Types.check(binding, {
                  'path' => String,
                  'file' => String
                })

    Open3.popen3("node #{file}", :chdir=>path) do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join

      raise RunError.new(err) unless err.empty?

      stdout.readlines.join
    end
  end

  def JavaScript.with_code_written_to_temporary_file(code)
    Types.check(binding, { 'code' => String })
    
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        write_code_to_file(code, FILE_NAME)
        yield FILE_NAME
      end
    end
  end

  def JavaScript.write_code_to_file(code, name=FILE_NAME)
    Types.check(binding, {
                  'name' => String,
                  'code' => String
                })

    File.open("#{name}.js", "w") do |out|
      out.write(code)
    end
  end

  def JavaScript.evaluate_expression(code)
    code = <<-END
      var x = #{code};

      if ( typeof(x) === 'string' ) console.log('"' + x + '"');
      else console.log(x);
    END

    JavaScript.run(code).strip
  end

  def JavaScript.aux_library
    <<-'END'.unindent
    var aux = (function () {
      function stringOfValue(value) {
        if ( typeof(value) === 'string' ) {
          return '"' + value + '"';
        }
        else if ( value instanceof Array )
        {
            var result = "[";

            for ( var i = 0; i !== value.length; ++i )
            {
                if ( i !== 0 )
                {
                    result = result.concat(",");
                }

                result = result.concat( stringOfValue(value[i]) );
            }

            return result.concat("]");
        }
        else
        {
          return "" + value;
        }
      }

      function print(str) {
        console.log(str);
      }

      function println(str) {
        print(str + "\n");
      }

      function printVar(id, val) {
        println(id + "=" + stringOfValue(val));
      }

      return { stringOfValue: stringOfValue,
               print: print,
               println: println,
               printVar: printVar
             };
    })();
    END
  end
end
