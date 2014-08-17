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

add( 'hintbox-types', Questions::Java::TypeInference.new( <<END.strip ) )
class HintBox {
    /*
      De letter in de HintBox.
    */
    private __char__ letter;

    /*
      Houdt bij of de letter zichtbaar is of niet.
    */
    private __boolean__ revealed;

    /*
      Constructor.
    */
    public Game( __char__ letter ) { ... }

    /*
      Deze methode oproepen stelt het raden van een letter voor.
      Geeft als resultaat terug of de geraden letter
      overeenkwam met de letter in de HintBox.
    */
    public __boolean__ guess(__char__ letter) { ... }

    /*
      Geeft terug of de letter zichtbaar is of niet.
    */
    public __boolean__ isRevealed() { ... }

    /*
      Geeft de letter terug indien de letter geraden werd,
      '_' in het andere geval.
    */
    public __char__ show() { ... }
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
