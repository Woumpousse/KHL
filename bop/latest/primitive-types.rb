require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Exercises
  include Controller

  def fill_in_types_person
    question = Questions::Java::AutoFillInTypes.new.parse( <<-'END'.unindent.strip )
      class Persoon
      {
          private String naam;
          private int leeftijd;
          private boolean isMan;
          private double lengteInMeter;

          // Constructor
          public Person(String naam,
                        int leeftijd,
                        boolean isMan,
                        double lengte) {
              ...
          }

          // Getters
          public String getNaam() { ... }
          public int getLeeftijd() { ... }
          public boolean isMan() { ... }
          public double lengteInMeter() { ... }

          // Setters
          public void setNaam(String naam) {
              ...
          }

          public void setLeeftijd(int leeftijd) {
              ...
          }

          public void setMan(boolean isMan) {
              ...
          }

          public void setLengteInMeter(double lengte) {
              ...
          }
      }
    END


    question
  end

end
