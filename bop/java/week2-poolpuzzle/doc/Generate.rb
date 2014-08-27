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

# Vul de types van de instantievariabelen in de klasse Persoon aan, kies uit:
add( 'fill_in_types_persoon', Questions::Java::FillInBlanks.new( <<END.strip ) )
public class Persoon {
    /* Bevat de voornaam van de persoon */
    private __type:String__ voornaam ;
    /* Bevat de familienaam van de persoon */
    private __type:String__ familienaam ;
    /* Bevat de leeftijd van de persoon */
    private __type:int__ leeftijd ;
    /* Of de persoon gehuwd is of niet */
    private __type:boolean__ isGetrouwd ;
    ...
}
END

# Vul de types van de instantievariabelen in de klasse Persoon aan, kies uit:
add( 'fill_in_types_getters_persoon', Questions::Java::FillInBlanks.new( <<END.strip ) )
public class Persoon {
    ...
    /* Geeft de voornaam van de persoon terug*/
    public __type:String__ getVoornaam(__parameters:blanco__){
	   return this.voornaam ;
    }
    /* Geeft de familienaam van de persoon terug*/
    public String __methode naam:getFamilieNaam__()      {
	   return __java keyword:this__.familienaam;
    }
	
    /* Geeft de leeftijd van de persoon terug*/
    public int getLeeftijd__haakjes:()__ {
	   return this.leeftijd;
    }
	
    ...
}
END

add( 'who_am_i', Questions::Java::FillInBlanks.new( <<END.strip ) )
 Een .__:class__bestand wordt gecompileerd van een __:java__ bestand
 De instantievariabelen van twee __:object__en kunnen verschillend zijn
 Een __:klasse__ gedraagt zich zoals een template
 Een __:methode__ doet iets
 Een __:klasse__ kan meerdere methodes hebben
 Een __:object__ stelt een status voor
 Een __:object__ heeft gedrag
 Een eigenschap van een object worden bijgehouden in een __:instantie variabele__
 Een __:object__ wordt in het heap geheugen bewaard
 Een object instantie maak je op basis van een __:klasse__
 De inhoud van een __:instantie variabele__ van een object kan wijzigen
 Een __:klasse__ definieert methodes
 Een __:object__ kan tijdens de uitvoering van de code wijzigen
END

add( 'pool_puzzle', Questions::Java::FillInBlanks.new( <<END.strip ) )
public class VoerUit {
    public static void main(String[] args) {
	Echo e1 = new Echo();
        __statement:Echo e2 = new Echo()__;
        int x = 0;
        while(__vergelijking:x<4__) {
            e1.hello();
            e1.add(__statement:x*2__);
            if(__vergelijking:x==3__) {
            	e1.add(__variabele:e2__.getCount());
            }
            if(__vergelijking:x>1__) {
            	e2.add(__variabele:e1__.getCount());
            }
            x++;
        }
        e2.print();
    }
}
public class Echo {
    /* Houdt een getal bij */
    private int __identifier:count__ = 0;

    /* Print enkel hellooo uit */
    public void __methode naam:hello__() {
	System.out.println("helloooo..");
    }

    /* Telt de waarde van i op bij zijn getal */
    public void add(int i) {
	this.__variabele naam:count__ = this.__idem:count__ + __parameter:i__;
    }
    public int getCount() {
	return this.__instantievariabele naam:count__;
    }
    /* Print zijn getal uit */
    public void print() {
	System.out.println(this.__instantievariabele naam:count__);
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
