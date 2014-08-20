require './Questions.rb'
require './Controller.rb'
require './Shared.rb'

class Exercises
  include Controller

  def fill_in_blanks
    Questions::Java::FillInBlanks.new( <<-END.unindent.strip )
      class Foo
      {
          __access modifier:public__ static void __identifier:main__(String[] args)
          {
              __type:int__ x = 5;

              System.out.println(x);
          }
      }   
      END
  end
end
