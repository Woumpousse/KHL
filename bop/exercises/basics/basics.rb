require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller
  def hello_world
    Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        __`class`__ HelloWorld
        {
            public static void __`main`__(String[] args)
            {
                System.out.__`println`__("__`Hello World`__");
            }
        }
      END
  end
end
