require './Questions.rb'
require './Controller.rb'
require './Generation.rb'




class Exercises
  include Controller

  def persoon
    question = Questions::Java::AutoFillInTypes.new.parse( <<-'END'.unindent.strip )
      class Persoon
      {
          private String naam;
          private int leeftijd;
          private boolean isMan;
          private double lengteInMeter;
          private double gewichtInKg;

          // Constructor
          public Person(String naam,
                        int leeftijd,
                        boolean isMan,
                        double lengte,
                        double gewicht) {
              ...
          }

          // Getters
          public String getNaam() { ... }
          public int getLeeftijd() { ... }
          public boolean isMan() { ... }
          public double getLengteInMeter() { ... }
          public double getGewicht() { ... }
          public double getBMI() { ... }

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

          public void setGewichtInKg(double gewicht) {
              ...
          }
      }
    END

    question.class_name = 'Persoon'

    question
  end

  def film
    question = Questions::Java::AutoFillInTypes.new.parse( <<-'END'.unindent.strip )
      class Film
      {
          private String titel;
          private int lengteInMinuten;
          private boolean knt; // kinderen niet toegelaten
          private int jaar;
          private String regisseur;

          // Constructor
          public Film(String titel,
                      int lengteInMinuten,
                      boolean knt,
                      int jaar,
                      String regisseur)
          {
              ...
          }

          // Getters
          public String getTitel() { ... }
          public int getLengteInMinuten() { ... }
          public double getLengteInUur() { ... }
          public int getJaar() { ... }
          public String getRegisseur() { ... }

          // Setters
          public void setTitel(String titel) {
              ...
          }

          public void setLengteInMinuten(int lengte) {
              ...
          }

          public void setKnt(boolean knt) {
              ...
          }

          public void setJaar(int jaar) {
              ...
          }

          public void setRegisseur(String regisseur) {
              ...
          }
      }
    END

    question.class_name = 'Film'

    question
  end
end


def template(exercise)
  <<END
<!DOCTYPE html>
<html>
  <head>
    <title><%= #{exercise}.class_name %></title>
    <meta charset="utf-8">
    <script src="jquery.js"></script>
    <script src="khl.js"></script>
    <link rel="stylesheet" href="khl.css">
  </head>
  <body>
    <div id="contents">
      <h1>Types</h1>
      <section>
        <h2>Klasse <%= #{exercise}.class_name %></h2>
        <div data-question="fill-in-blanks">
          <p>
            Vul de juiste types in. Je hebt de keuze tussen
          </p>
          <%= HTML::unordered_list( #{exercise}.answers.sort.uniq, { 'class' => 'pool' } ) %>
          <pre><%= #{exercise}.code %></pre>
        </div>
      </section>
    </div>
  </body>
</html>
END
end


def main
  exercises = Exercises.new

  %w(persoon film).each do |exercise_id|
    File.open("#{exercise_id}.html", 'w') do |out|
      result = Generation.generate( exercises, template( exercise_id ) )

      out.write( result )
      
    end
  end
end


main
