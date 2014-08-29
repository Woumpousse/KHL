require 'optparse'
require './Shared.rb'
require './Exercise.rb'
require './ExercisePool.rb'
require './Exercises.rb'
require './LaTeX.rb'



def parse_command_line_arguments
  options = {}

  optparse = OptionParser.new do |opts|
    opts.banner = <<-END.unindent
      Mighty Inverse Query Generator
      Created by F. Vogels
      Dedicated to the one and only G.B.

    END

    options[:verify] = false
    opts.on( '-v', '--verify', 'Verify all exercises') do
      options[:verify] = true
    end

    options[:template] = 'template.tex'
    opts.on( '-t', '--template FILE', 'Template to be used', 'Defaults to template.tex') do |file|
      options[:template] = file
    end

    options[:exercise_count] = nil
    opts.on( '-n', '--count NUM', Integer, 'Number of exercises to pick', 'Required to produce output') do |count|
      options[:exercise_count] = count
    end

    options[:min_categories] = Set.empty
    opts.on( '--min-categories a,b,c', Array, 'Minimum allowed categories') do |cats|
      options[:min_categories] = Set.new( *cats )
    end

    options[:max_categories] = Set.universe
    opts.on( '--max-categories a,b,c', Array, 'Maximum allowed categories') do |cats|
      options[:max_categories] = Set.new( *cats )
    end

    options[:stats] = false
    opts.on( '--stats', 'Show statistics') do |cats|
      options[:stats] = true
    end

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  optparse.parse!
  options
end


def statistics
  exercises = ExercisePool::exercises
  categories = ExercisePool::all_categories.items

  puts <<-END.unindent
    Total number of exercises: #{exercises.length}
    Total number of categories: #{categories.length}
  END

  categories.each do |category|
    selection = ExercisePool::select do |exercise|
      exercise.categories.superset_of?( Set.new(category) )
    end

    puts "Category '#{category}': #{selection.length} exercises"
  end
end

def verify
  error_count = 0

  ExercisePool::exercises.each do |exercise|
    begin
      exercise.solution
    rescue Database::DatabaseError => e
      error_count += 1

      puts <<END
Error in exercise defined on line #{exercise.line} in file #{exercise.file}
Error message:
#{e.message}

END
    end
  end

  if error_count > 0 then
    puts "#{error_count} error(s) found"
    abort
  end  
end


def generate_assignment(exercise_count, template)
  selection = ExercisePool::pick(exercise_count) do |exercise|
    yield exercise
  end

  template_string = IO.read(template)

  LaTeX::format_bundle( template_string, selection )
end



def main
  options = parse_command_line_arguments

  verify if options[:verify]
  statistics if options[:stats]

  if options[:exercise_count] then
    assignment = generate_assignment(options[:exercise_count], options[:template]) do |exercise|
      cats = exercise.categories
      mincats = options[:min_categories]
      maxcats = options[:max_categories]


      cats.subset_of?( maxcats ) and cats.superset_of?( mincats )
    end
    
    puts assignment
  end
end


main
