require 'tmpdir.rb'
require 'open3'
require './Types.rb'

module Java
  class JavaError < StandardError
    def initialize(classes, message)
      super(message)
      @classes = classes
    end

    attr_reader :classes
  end

  class CompilationError < JavaError
    def initialize(classes, message)
      super(classes, message)
    end
  end

  class RunError < JavaError
    def initialize(classes, message)
      super(classes, message)
    end
  end

  class InvocationError < StandardError
    def initialize(message)
      super(message)
    end
  end


  class Bundle
    def self.from_string(string)
      Bundle.new( split(string) )
    end

    def initialize(files)
      Types.check(binding, { :files => {String => String} })

      @files = files
    end

    def files
      @files.keys
    end

    def [](file)
      Types.check(binding, { :file => String })

      @files[file]
    end

    def while_written
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          write_classes_to_files

          yield
        end
      end
    end

    def to_s
      @files.values.join("\n")
    end

    private
    def self.split(code)
      Types.check(binding, { :code => String })

      Hash[ code.scan(/^class.*?(?=class|\z)/m).map do |class_code|
        [ Bundle.find_class_name(class_code), class_code ]      
      end ]
    end

    def self.find_class_name(code)
      Types.check(binding, { :code => String })

      matches = code.scan(/(class|interface) (\w+)/)

      if matches.length != 1 then
        abort "Could not find class name\n#{code}"
      else
        matches[0][1].strip
      end
    end

    def write_classes_to_files
      files.each do |file|
        Bundle.write_class_to_file(file, self[file])
      end
    end

    def self.write_class_to_file(name, code)
      Types.check(binding, {
                    :name => String,
                    :code => String
                  })

      File.open("#{name}.java", "w") do |out|
        out.write(code)
      end
    end
  end


  def Java.run(bundle, main_class='App')
    Types.check(binding, { :bundle => Bundle  })

    bundle.while_written do
      begin
        Java.invoke_compiler('*.java')
      rescue InvocationError => e
        raise CompilationError.new(bundle, e.message)
      end

      begin
        Java.invoke_vm(main_class)
      rescue InvocationError => e
        raise RunError.new(bundle, e.message)
      end
    end
  end

  def Java.compile(bundle)
    Types.check(binding, { :bundle => Bundle })
    
    bundle.while_written do
      begin
        Java.invoke_compiler('*.java')
      rescue InvocationError => e
        raise CompilationError.new(bundle, e.message)
      end
    end
  end

  def Java.invoke_compiler(path='*.java')
    Types.check(binding, { :path => String })

    Open3.popen3("javac #{path}") do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join
      
      raise InvocationError.new(err) unless err.empty?
    end
  end

  def Java.invoke_vm(main_class = "App", path='.')
    Types.check(binding, {
                  :path => String,
                  :main_class => String
                })

    Open3.popen3("java #{main_class}", :chdir=>path) do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join

      raise InvocationError.new(err) unless err.empty?

      stdout.readlines.join
    end
  end
end

