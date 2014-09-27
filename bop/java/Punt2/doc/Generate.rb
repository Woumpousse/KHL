require 'optparse'
require './Questions.rb'
require './Controller.rb'
require './Parameters.rb'
require './Generation.rb'


def parse_command_line_arguments
  options = {}

  optparse = OptionParser.new do |opts|
    opts.banner = "KHL Generator"

    options[:verify] = false
    opts.on( '-v', '--verify', 'Verify code where possible') do
      options[:verify] = true
    end

    options[:template] = nil
    opts.on( '-t', '--template FILE', 'Template to be used') do |file|
      options[:template] = file
    end

    options[:required] = []
    opts.on( '-r', '--require FILE', 'Ruby files to be loaded') do |file|
      options[:required].push(file)
    end

    options[:class] = nil
    opts.on( '-c', '--class IDENTIFIER', 'Class containing exercises') do |file|
      options[:class] = file
    end

    options[:output] = nil
    opts.on( '-o', '--output FILE', 'Output file') do |file|
      options[:output] = file
    end

    options[:passes] = 1
    opts.on( '-p', '--passes NUM', Integer, 'Number of ERB expansions', 'Defaults to 1') do |n|
      options[:passes] = n.to_i
    end

    opts.on( '-P', '--parameter KEY=VALUE', 'Define parameter') do |pair|
      if pair =~ /^([^=]+)=([^=]+)$/
      then
        key, val = $1, $2
        Parameters.add(key, val)
      else
        raise "Invalid parameter \"#{pair}\""
      end
    end

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  optparse.parse!

  options
end


def dynamically_load(file)
  abort "No exercises specified" unless file

  puts "Loading file #{file}..."
  begin
    require file
  rescue LoadError => e
    puts "Failed to load #{file}..."
    puts 'Possible remedy: use "./file" instead of "file"'
    puts "Error:\n#{e}"
    abort
  end

  puts "Successfully loaded #{file}..."
end


def verify
  abort "Verification not supported yet"
end


def generate(class_name, template, output, passes)
  abort "No class specified" unless class_name
  abort "No template specified" unless template
  abort "No output specified" unless output

  File.open( output, "w" ) do |file|
    puts "Reading template #{template}"
    template_data = IO.read(template)
    puts "Loaded template #{template} successfully"

    puts "Looking for class #{class_name}"
    resource_class = Kernel.const_get(class_name)
    
    puts "Instantiating class #{class_name}"
    resources = resource_class.new

    puts "Processing template"
    result = Generation.generate(resources, template_data, passes)
    puts "Successfully processed template"

    puts "Writing to file #{output}"
    file.write( result )
  end
end


def main
  options = parse_command_line_arguments

  options[:required].each do |file|
    dynamically_load(file)
  end

  if options[:verify]
  then verify
  end

  if options[:template] or options[:output]
  then generate(options[:class], options[:template], options[:output], options[:passes])
  end

  puts "Done!"
end


main
