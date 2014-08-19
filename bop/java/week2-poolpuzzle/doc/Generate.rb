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


add( 'pool_puzzle', Questions::Java::SelectCodeFragments.new( <<END.strip ) )
public class VoerUit {
    public static void main(String[] args) {
	Echo e1 = new Echo();
	%Echo e2 = new Echo();
	int x = 0;
	while(%x<3 ) {
		e1.hello();
                %e1.add(1)
		if(%x<3) {
			e2.add(1);
		}
		if(%x>1) {
			e2.add(e1.getCount())
		}
		x++;
	}
	e2.print();
    }
}
public class Echo {
    /* Houdt een getal bij */
    private int %count = 0;

    /* Print enkel hellooo uit */
    public void %hello() {
	System.out.println("helloooo..");
    }

    /* Telt de waarde van i op bij zijn getal */
    public void add(int i) {
	this.%count = this.%count + %i;
    }
    public int getCount() {
	return this.%count;
    }
    /* Print zijn getal uit */
    public void print() {
	System.out.println(this.%count);
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
