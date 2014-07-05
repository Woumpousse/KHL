require 'tmpdir.rb'
require 'open3'

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

  def self.compile(path)
    Open3.popen3("javac #{path}") do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join
      
      raise CompilationError.new(err) unless err.empty?
    end
  end

  def self.run(path, main_class = "App")
    Open3.popen3("java #{main_class}", :chdir=>path) do |stdin, stdout, stderr, wait_thr|
      err = stderr.readlines.join

      raise RunError.new(err) unless err.empty?

      stdout.readlines.join
    end
  end

  def self.write_class_to_file(name, code)
    raise "Name \"#{name}\" must be string" unless name.is_a?(String)
    raise "Code \"#{code}\" must be string" unless code.is_a?(String)

    File.open("#{name}.java", "w") do |out|
        out.write(code)
      end
  end

  def self.write_classes_to_files(classes)
    classes.each_pair do |name, code|
      write_class_to_file(name, code)
    end
  end

  # Takes a hash[filename=>code]
  def self.must_compile(classes)
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        write_classes_to_files(classes)
        Java.compile('*.java')
      end
    end
  end

  def self.must_not_compile(classes)
    begin
      must_compile(classes)
      raise CompilationFailureError.new(classes)
    rescue CompilationError
      true
    end
  end      

  def self.find_class_name(code)
    matches = code.scan(/(class|interface) (\w+)/)

    if matches.length != 1 then
      abort "Could not find class name\n#{code}"
    else
      matches[0][1].strip
    end
  end
end
