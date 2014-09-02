require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Train < Controller
  def fields
    once(__method__) do
      Questions::Java::FillInTypes.new.parse( <<-'END'.unindent.strip )
        class Wagon
        {
            private __int__ capacity;
            private __Wagon__ tail;
        }   
      END
    end
  end

  def train_creation
    once(__method__) do
      Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        // Aanmaak linkerwagon
        __type`Wagon`__ w1 = __keyword`new`__ __type`Wagon`__(__capacity`10`__);

        // Aanmaak middelste wagon
        __type`Wagon`__ w2 = __keyword`new`__ __type`Wagon`__(__capacity`20`__);

        // Aanmaak rechterwagon
        __type`Wagon`__ w3 = __keyword`new`__ __type`Wagon`__(__capacity`30`__);

        // Linkerwagon koppelen aan middelste wagon
        __identifier`w1`__.__identifier`attach`__( __identifier`w2`__ );

        // Middelste wagon koppelen aan rechterwagon
        __identifier`w2`__.__identifier`attach`__( __identifier`w3`__ );
      END
    end
  end

  def getLength
    once(__method__) do
      Questions::Java::FillInBlanks.new.parse( <<-'END'.unindent.strip )
        class Wagon
        {
            public __type`int`__ getLength()
            {
                int tailLength;

                if ( __methode-oproep`isLast()`__ )
                {
                    // Indien deze wagon de laatste is
                    tailLength = 0;
                }
                else
                {
                    // Er komen nog wagons na de deze
                    tailLength = __identifier`getTail`__().__identifier`getLength`__();
                }

                return __literal`1`__ + tailLength;
            }
        }
      END
    end
  end
end
