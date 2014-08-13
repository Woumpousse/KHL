require './Questions.rb'
require './Java.rb'


module Exercises

  class TypeInference1 < Questions::Java::FillInBlanksInCode
    def initialize
      super( <<-END.unindent )
               class Foo {
                   public __void__ foo() {
                       // NOP
                   }
               }
             END
    end
  end
  
end


$output = IO.read('test.html').gsub(/#\{(.*?)\}/) do
  Exercises.const_get($1.to_sym).new.html
end

puts $output
