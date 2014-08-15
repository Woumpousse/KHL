require './Questions.rb'
require './Java.rb'


module Exercises
  class TypeInference1 < Questions::Java::TypeInference
    def initialize
      super( <<-END.unindent.strip )
               class Foo {
                   public __void__ foo() {
                     // NOP
                   }
                 }
                 END
    end
  end

  # class Scopes1 < Questions::Java::SelectTokens
  #   def initialize
  #     super( <<-END.unindent.strip )
  #              class Foo {
  #                  public %void foo() {
  #                  }
  #              }
  #              END
  #   end
  # end

  class Scopes1 < Questions::Java::SelectLines
    def initialize
      super( <<-END.unindent.strip )
               class Foo {
                   public void foo() {     <<
                   }
               }
               END
    end
  end
end

def produce_html
  output = IO.read('test.html').gsub(/#\{(.*?)\}/) do
    Exercises.const_get($1.to_sym).new.html
  end
  
  puts output
end

def verify_all
  Exercises.constants.each do |constant|
    exercise = Exercises.const_get(constant)

    exercise.new.verify
  end
end

if ARGV.length == 0
then abort "Expected command"
else
  command = ARGV[0]

  case command
  when "html"
  then produce_html
  when "check"
  then verify_all
  else abort "Unrecognized command #{command}"
  end
end
