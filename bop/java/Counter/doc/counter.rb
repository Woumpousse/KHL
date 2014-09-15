require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller

  def pick_field
    once(__method__) do
      # Syntax: lines to be selected must end on <<
      Questions::Java::SelectLines.new.parse( <<-'END'.unindent.strip )
        class Counter
        {
            private int value; <<

            public Counter()
            {
                this.value = 0;
            }

            public void increment()
            {
                this.value += 1;
            }

            public int getValue()
            {
                return this.value;
            }

            public void reset()
            {
                this.value = 0;
            }
        }
      END
    end
  end

  def pick_constructor
    once(__method__) do
      # Syntax: lines to be selected must end on <<
      Questions::Java::SelectLines.new.parse( <<-'END'.unindent.strip )
        class Counter
        {
            private int value;

            public Counter() <<
            { <<
                this.value = 0; <<
            } <<

            public void increment()
            {
                this.value += 1;
            }

            public int getValue()
            {
                return this.value;
            }

            public void reset()
            {
                this.value = 0;
            }
        }
      END
    end
  end

  def pick_method_identifiers
    once(__method__) do
      # Syntax: lines to be selected must end on <<
      Questions::Java::SelectTokens.new.parse( <<-'END'.unindent.strip )
        class Counter
        {
            private int value;

            public Counter()
            {
                this.value = 0;
            }

            public void __increment__()
            {
                this.value += 1;
            }

            public int __getValue__()
            {
                return this.value;
            }

            public void __reset__()
            {
                this.value = 0;
            }
        }
      END
    end
  end

  def counter_code
    <<-END.unindent
        class Counter
        {
            private int value;

            public Counter()
            {
                this.value = 0;
            }

            public void increment()
            {
                this.value += 1;
            }

            public int getValue()
            {
                return this.value;
            }

            public void reset()
            {
                this.value = 0;
            }
        }
    END
  end

  def interpret1
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, counter_code )
        class App
        {
            public static void main(String[] args)
            {
                // We maken een nieuwe counter aan
                Counter counter = new Counter();

                // We printen de huidige waarde van
                // het aangemaakte Counter-object af
                System.out.println( counter.getValue() );
            }
        }
      END
    end
  end

  def interpret2
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, counter_code)
        class App
        {
            public static void main(String[] args)
            {
                // We maken een nieuwe counter aan
                Counter counter = new Counter();

                // We verhogen de counter met 1
                counter.increment();

                // We printen de huidige waarde van
                // het aangemaakte Counter-object af
                System.out.println( counter.getValue() );
            }
        }
      END
    end
  end

  def interpret3
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, counter_code)
        class App
        {
            public static void main(String[] args)
            {
                Counter counter = new Counter();

                counter.increment();
                counter.increment();
                counter.increment();
                counter.increment();

                System.out.println( counter.getValue() );
            }
        }
      END
    end
  end

  def interpret4
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, counter_code)
        class App
        {
            public static void main(String[] args)
            {
                Counter counter = new Counter();

                counter.increment();
                counter.increment();
                counter.increment();
                counter.increment();

                counter.reset();

                System.out.println( counter.getValue() );
            }
        }
      END
    end
  end

  def interpret5
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, counter_code)
        class App
        {
            public static void main(String[] args)
            {
                Counter counter1 = new Counter();
                Counter counter2 = new Counter();

                counter1.increment();
                counter1.increment();
                counter2.increment();

                // Print "x,y" af, met x de waarde van counter1
                // en y de waarde counter counter2
                System.out.println( counter1.getValue() +
                                    "," +
                                    counter2.getValue() );
            }
        }
      END
    end
  end

  def format(code)
    HTML::Formatters::JavaFormatter.new.apply(code)
  end

  def empty_test_code
    <<-'END'.unindent
      import static org.junit.Assert.*;


      public class Test
      {

          @org.junit.Test
          public void test()
          {
              fail( "Not yet implemented" );
          }

      }
    END

  end

  def test_code
    <<-'END'.unindent
      import static org.junit.Assert.*;

      import org.junit.*;


      public class CounterTest
      {
          @Test
          public void constructor()
          {
              Counter counter = new Counter();

              assertEquals(0, counter.getValue());
          }

          @Test
          public void increment()
          {
              Counter counter = new Counter();

              counter.increment();

              assertEquals(1, counter.getValue());
          }

          @Test
          public void incrementFourTimes()
          {
              Counter counter = new Counter();

              counter.increment();
              counter.increment();
              counter.increment();
              counter.increment();

              assertEquals(4, counter.getValue());
          }

          @Test
          public void reset()
          {
              Counter counter = new Counter();

              counter.increment();
              counter.increment();
              counter.increment();
              counter.increment();

              counter.reset();

              assertEquals(0, counter.getValue());
          }
      }
    END
  end

  def extra_test_code
    <<-'END'.unindent
      @Test
      public void decrement()
      {
          // Aanmaak Counter-object
          Counter counter = new Counter();

          // Incrementeren, 0 -> 1
          counter.increment();

          // Decrementer, 1 -> 0
          counter.decrement();

          // Verifieer dat counter op 0 staat
          assertEquals(0, counter.getValue());
      }
    END
  end
end
