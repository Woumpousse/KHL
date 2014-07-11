require 'tmpdir.rb'
require 'open3'
require './Types.rb'

module Java  
  class JavaError < StandardError
    def initialize(message)
      super(message)
    end
  end

  class CompilationError < JavaError
    def initialize(message)
      super(message)
    end
  end

  class CompilationFailureError < JavaError
    def initialize(code)
      super("Should not compile")
      @code = code
    end

    def to_s
      code = @code.values.join("\n")
      "Should not compile\n#{code}"
    end
  end

  class RunError < JavaError
    def initialize(message)
      super(message)
    end
  end

  def Java.with_files(classes)
    Types.check(binding, { 'classes' => {String => String} })
    
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        write_classes_to_files(classes)

        yield
      end
    end
  end

  def Java.execute(classes, main_class='App')
    Types.check(binding, { 'classes' => {String => String} })

    with_files(classes) do
      begin
        Java.compile('*.java')
        Java.run(main_class)
      end
    end
  end

  def Java.compile(classes)
    Types.check(binding, { 'classes' => {String => String} })
    
    with_files(classes) do
      Java.compile('*.java')
    end
  end

  def Java.find_class_name(code)
    Types.check(binding, { 'code' => String })

    matches = code.scan(/(class|interface) (\w+)/)

    if matches.length != 1 then
      abort "Could not find class name\n#{code}"
    else
      matches[0][1].strip
    end
  end

  # Takes one string containing multiple class definitions and transforms it into a hash
  def Java.split_in_files(code)
    Types.check(binding, { 'code' => String })

    Hash[ code.scan(/^class.*?(?=class|\z)/m).map do |class_code|
      [ find_class_name(class_code), class_code ]      
    end ]
  end

  def Java.compile(path='*.java')
    Types.check(binding, { 'path' => String })

    Open3.popen3("javac #{path}") do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join
      
      raise CompilationError.new(err) unless err.empty?
    end
  end

  def Java.run(main_class = "App", path='.')
    Types.check(binding, {
                  'path' => String,
                  'main_class' => String
                })

    Open3.popen3("java #{main_class}", :chdir=>path) do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join

      raise RunError.new(err) unless err.empty?

      stdout.readlines.join
    end
  end

  def Java.write_class_to_file(name, code)
    Types.check(binding, {
                  'name' => String,
                  'code' => String
                })

    File.open("#{name}.java", "w") do |out|
      out.write(code)
    end
  end

  def Java.write_classes_to_files(classes)
    Types.check(binding, { 'classes' => {String => String} })

    classes.each_pair do |name, code|
      write_class_to_file(name, code)
    end
  end
end

