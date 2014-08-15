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


add( 'infer-types-1', Questions::Java::TypeInference.new( <<END.strip ) )
class Foo {
    public __void__ foo() {
      // NOP
    }

    public __int__ bar(__boolean__ x) {
      if ( x ) { return 0; }
      else { return 1; }
    }
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


def produce_html
  output = IO.read('test.html').gsub(/#\{(.*?)\.(.*?)\}/) do
    label, member = $1, $2

    get($1).send($2.to_sym)
  end
  
  puts output
end

def verify_all
  Exercises.constants.each do |constant|
    exercise = Exercises.const_get(constant)

    exercise.new.verify
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
