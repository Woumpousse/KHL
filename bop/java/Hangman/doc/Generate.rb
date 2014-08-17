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


add( 'game-types', Questions::Java::FillInTypes.new( <<END.strip ) )
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

add( 'game-test', Questions::Java::FillInLiterals.new( <<END.strip ) )
// Nieuw spel begint met 7 levens.
Game game = new Game( "jazz" );

assertEquals( __false__, game.isGameOver() );
assertEquals( __7__, game.getLivesLeft() );
assertEquals( "_ _ _ _", game.show() );

/*
  De speler gokt een juiste letter.
  Aantal levens blijft onveranderd, letter wordt getoond.
*/
game.guess('a');

assertEquals( __false__, game.isGameOver() );
assertEquals( __7__, game.getLivesLeft() );
assertEquals( __"_ a _ _"__, game.show() );

/*
  De speler gokt een verkeerde letter.
  Een leven gaat verloren.
*/
game.guess('q');

assertEquals( __false__, game.isGameOver() );
assertEquals( __6__, game.getLivesLeft() );
assertEquals( __"_ a _ _"__, game.show() );

/*
  Koppige speler.
*/
game.guess('x');
assertEquals( __5__, game.getLivesLeft() );
game.guess('x');
assertEquals( __4__, game.getLivesLeft() );
game.guess('x'); game.guess('x'); game.guess('x');
assertEquals( __1__, game.getLivesLeft() );
game.guess('x');
assertEquals( __0__, game.getLivesLeft() );
assertEquals( __true__, game.isGameOver() );
assertEquals( __false__, game.isGameWon() );
assertEquals( __true__, game.isGameLost() );
END

add( 'hintbox-types', Questions::Java::FillInBlanks.new( <<END.strip ) )
class HintBox {
    /*
      De letter in de HintBox.
    */
    __access modifier:private__  __type:char__ letter;

    /*
      Houdt bij of de letter zichtbaar is of niet.
    */
    __access modifier:private__ __type:boolean__ revealed;

    /*
      Constructor.
    */
    public __identifier:HintBox__( __type:char__ letter ) { ... }

    /*
      Deze methode oproepen stelt het raden van een letter voor.
      Geeft als resultaat terug of de geraden letter
      overeenkwam met de letter in de HintBox.
    */
    public __type:boolean__ guess(__type:char__ letter) { ... }

    /*
      Geeft terug of de letter zichtbaar is of niet.
    */
    public __type:boolean__ isRevealed() { ... }

    /*
      Geeft de letter terug indien de letter geraden werd,
      '_' in het andere geval.
    */
    public __type:char__ show() { ... }
}
END

add( 'hint-types', Questions::Java::FillInTypes.new( <<END.strip ) )
class Hint {
    /*
      De HintBox-objecten
    */
    private __HintBox[]__ hintboxes;

    /*
      Constructor.
    */
    public Hint( __String__ word ) { ... }

    /*
      Deze methode oproepen stelt het raden van een letter voor.
      Geeft als resultaat terug of de geraden letter
      in minstens een van de HintBoxes voorkwam.
    */
    public __boolean__ guess(__char__ letter) { ... }

    /*
      Geeft na of de letters in alle HintBox-objecten zichtbaar zijn.
    */
    public __boolean__ isFullyRevealed() { ... }

    /*
      Roept de show-methode op van alle HintBoxes en voegt
      de resultaten samen met telkens een spatie ertussen.
    */
    public __String__ show() { ... }
}
END


add( 'game-types-fields', Questions::Java::FillInBlanks.new( <<END.strip ) )
class Game {
    __access modifier:private__ __type:Hint__ hint;
    __access modifier:private__ __type:int__ livesLeft;

    /* Rest van de klasse */
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
