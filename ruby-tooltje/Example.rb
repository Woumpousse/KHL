require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Examples < Controller
  def fill_in_blanks
    # once ensures the question is only built once
    # It's merely an optimization
    once(__method__) do
      # Syntax: __placeholder`solution`validator__
      # Validator can be left blank, 'exact' will be used
      Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        class Foo
        {
            __access modifier`public`__ static void __identifier`main`__(String[] args)
            {
                __type`int`__ x = 5;

                System.out.println(x);
            }
        }   
      END
    end
  end


  def fill_in_blanks_pooled
    once(__method__) do
      # Syntax: __placeholder`solution`validator__
      # Validator can be left blank, 'exact' will be used
      Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        class Foo
        {
            __access modifier`public`__ static void __identifier`main`__(String[] args)
            {
                __type`int`__ x = 5;

                System.out.println(x);
            }

            private __type`int`__ foo()
            {
                return 0;
            }
        }   
      END
    end
  end


  def fill_in_types
    once(__method__) do
      # Syntax: __solution__
      # 'exact' will be used as validator
      Questions::Java::FillInTypes.new.parse( <<-'END'.unindent.strip )
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
  end


  def fill_in_access_modifiers
    once(__method__) do
      # Syntax: __solution__
      Questions::Java::FillInAccessModifiers.new.parse( <<-'END'.unindent.strip )
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
  end


  def fill_in_blanks_validators
    once(__method__) do
      # Syntax: __placeholder`solution`validator__
      Questions::Java::FillInBlanks.new.parse( <<-END.unindent.strip )
          String s1 = "__literal`abc`exact__"; // abc exact
          String s2 = "__literal`abc`case_insensitive__"; // abc case insensitive
          String s3 = "__literal`abc`ignore_whitespace__"; // abc ignore whitespace
          double s3 = "__literal`5`double_precision_2__"; // 5, precision 0.01
      END
    end
  end


  def select_types
    once(__method__) do
      # Syntax: __must-be-selected__
      Questions::Java::SelectTokens.new.parse( <<-'END'.unindent.strip )
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
  end


  def interpret
    once(__method__) do
      # Classes must have no access modifier!
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip )
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
  end


  def select_lines
    once(__method__) do
      # Syntax: lines to be selected must end on <<
      Questions::Java::SelectLines.new.parse( <<-'END'.unindent.strip )
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

  def js_interpret
    once(__method__) do
      Questions::JavaScript::InterpretCode.new.parse( <<-'END'.unindent.strip )
        var x = 1;
        var y = 2;
        x *= 5;

        `hide:console.log('x=%d\n', x);`
        `hide:console.log('y=%d\n', y);`
      END
    end
  end
end
