require './Questions.rb'
require './Java.rb'

$data = Hash.new

def add(label, exercise)
  abort "Duplicate label #{label}" if $data.has_key? label

  $data[label] = exercise
end

def get(label)
  abort "Undefined label #{label}" unless $data.has_key? label

  $data[label]
end

def labels
  $data.keys
end


add( 'game-types', Questions::Java::TypeInference.new( <<END.strip ) )
class Game {
    /*
      Constructor. Initialiseert het spel met een te raden woord.
    */
    public Game( __String__ word ) { ... }

    /*
      Deze methode oproepen stelt het raden van een letter voor.
      Geeft geen resultaat terug.
    */
    public __void__ guess(__char__ letter) { ... }

    /*
      Geeft het aantal overblijvende levens terug.
    */
    public __int__ getLivesLeft() { ... }

    /*
      Toont de toestand van het spel terug, bv. "_ a _"
    */
    public __String__ show() { ... }

    /*
      Geeft terug of het spel voorbij is.
    */
    public __boolean__ isGameOver() { ... }

    /*
      Geeft terug of het spel gewonnen werd.
    */
    public __boolean__ isGameWon() { ... }

    /*
      Geeft terug of het spel verloren werd.
    */
    public __boolean__ isGameLost() { ... }
}
END


add( 'scopes-1', Questions::Java::SelectTokens.new( <<END.strip ) )
class Foo {
    public %void foo() {
    }
}
END


add( 'lines-1', Questions::Java::SelectLines.new( <<END.strip ) )
class Foo {
    private int x = 0;

    public Foo() {  <<
        this.x = 0; <<
    }               <<

    public void foo() {
    }
}
END


add( 'interpret-1', Questions::Java::InterpretCode.new( <<END.strip ) )
class App {
    public static void main(String[] args) {
        System.out.print("a");
    }
}
END



def substitute(selector)
  abort "Invalid selector #{selector}" unless selector =~ /^([^.]+)\.([^.]+)$/

  label, member = $1, $2
  get(label).send(member.to_sym)
end

def produce_html
  output = IO.read('assignment-template.html').gsub(/#\{(.+?)\}/) do
    selector = $1

    substitute(selector)
  end.gsub(/^\s*#<\{(.+?)\}/) do
    selector = $1

    substitute(selector)
  end
  
  puts output
end

def verify_all
  labels.each do |label|
    get(label).verify
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
