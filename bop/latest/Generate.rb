require 'optparse'
require './Questions.rb'
require './Controller.rb'


VERSION = 3

def parse_command_line_arguments
  options = {}

  optparse = OptionParser.new do |opts|
    opts.banner = "KHL Generator Release #{VERSION}"

    options[:verify] = false
    opts.on( '-v', '--verify', 'Verify code where possible') do
      options[:verify] = true
    end

    options[:template] = nil
    opts.on( '-t', '--template FILE', 'Template to be used') do |file|
      options[:template] = file
    end

    options[:exercises] = nil
    opts.on( '-e', '--exercises FILE', 'Exercise file to be used') do |file|
      options[:exercises] = file
    end

    options[:output] = nil
    opts.on( '-o', '--output FILE', 'Output file') do |file|
      options[:output] = file
    end

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  optparse.parse!
  options
end


def load_exercises(file)
  abort "No exercises specified" unless file

  puts "Loading file #{file}..."
  begin
    require file
  rescue LoadError => e
    puts "Failed to load #{file}..."
    puts 'Possible remedy: use "-e ./file" instead of "-e file"'
    puts "Error:\n#{e}"
    exit -1
  end
  puts "Successfully loaded #{file}..."
end


def verify
  abort "Verification not supported yet"
end


def generate(template, output)
  abort "No template specified" unless template
  abort "No output specified" unless output

  File.open( output, "w" ) do |file|
    puts "Reading template #{template}"
    template_data = IO.read(template)
    puts "Loaded template #{template} successfully"

    puts "Processing template"
    result = Exercises.new.process_template(template_data)
    puts "Successfully processed template"

    puts "Writing to file #{output}"
    file.write( result )
  end
end


def main
  options = parse_command_line_arguments

  load_exercises(options[:exercises])

  if options[:verify]
  then verify
  end

  if options[:template] or options[:output]
  then generate(options[:template], options[:output])
  end

  puts "Done!"
end


main
