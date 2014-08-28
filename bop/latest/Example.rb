require './Questions.rb'
require './Controller.rb'
require './Shared.rb'

class Exercises
  include Controller

  def fill_in_blanks
    # Syntax: __placeholder:solution__
    Questions::Java::FillInBlanks.new.parse( <<-END.unindent.strip )
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


  def fill_in_types
    # Syntax: __solution__
    Questions::Java::FillInTypes.new.parse( <<-END.unindent.strip )
      class Foo
      {
          public static __void__ main(__String[]__ args)
          {
              __int__ x = 5;

              System.out.println(x);
          }
      }   
    END
  end


  def fill_in_access_modifiers
    # Syntax: __solution__
    Questions::Java::FillInAccessModifiers.new.parse( <<-END.unindent.strip )
      class Foo
      {
          __private__ int foo;

          __public__ static void main(String[] args)
          {
              int x = 5;

              System.out.println(x);
          }          
      }   
    END
  end


  def fill_in_blanks_with_pool
    # Syntax: __placeholder:solution__
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



  def select_types
    # Syntax: __must-be-selected__
    Questions::Java::SelectTokens.new.parse( <<-END.unindent.strip )
      class Foo
      {
          public static __void__ main(__String[]__ args)
          {
              __int__ x = 5;

              System.out.println(x);
          }
      }   
    END
  end


  def interpret
    # Classes must have no access modifier!
    Questions::Java::InterpretCode.new.parse( <<-END.unindent.strip )
      class App
      {
          public static void main(String[] args)
          {
              int x = 5;

              System.out.print( x );
          }
      }
    END
  end


  def select_lines
    # Syntax: lines to be selected must end on <<
    Questions::Java::SelectLines.new.parse( <<-END.unindent.strip )
      class Foo
      {
          public Foo() <<
          {            <<
          }            <<

          public void bar()
          {
          }
      }
    END
  end

end
