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
end

