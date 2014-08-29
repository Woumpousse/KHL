require './Exercise.rb'


module ExercisePool
  @@exercises = []
  @@current_exercise = nil
  @@current_table = nil
  @@exercise_postprocessor = lambda { |exercise| }

  def self.exercises
    @@exercises
  end

  def self.exercise(file, line)
    abort "Nested exercises are not allowed" if @@current_exercise

    @@current_exercise = Exercise.new(file, line)
    yield
    @@exercise_postprocessor[@@current_exercise]
    @@current_exercise.finalize
    @@exercises.push( @@current_exercise )
    @@current_exercise = nil
  end

  def self.table(name, cols)
    abort "Nested tables are not allowed" if @@current_table
    abort "Table definitions only allowed within exercises" unless @@current_exercise

    @@current_table = Table.new(name, cols)
    yield
    @@current_table.finalize
    @@current_exercise.add_table( @@current_table )
    @@current_table = nil
  end

  def self.row(data)
    abort "Row definitions only allowed within tables" unless @@current_table

    @@current_table.add_row(data)
  end

  def self.query(string)
    abort "Query only allowed inside exercise" unless @@current_exercise
    abort "Query not allowed inside table" if @@current_table

    @@current_exercise.query = string.unindent  
  end

  def self.postprocess_exercise(processor)
    old_postprocessor = @@exercise_postprocessor

    @@exercise_postprocessor = lambda do |exercise|
      old_postprocessor[exercise]
      processor[exercise]
    end

    yield

    @@exercise_postprocessor = old_postprocessor
  end

  def self.metadata(hash)
    postprocess_exercise( lambda do |exercise|
                            hash.each do |k, v|
                              exercise[k] = v
                            end
                          end ) do
      yield
    end
  end

  def self.difficulty(n)
    metadata( { :difficulty => n } ) do
      yield
    end
  end

  def self.category(cat)
    postprocess_exercise( lambda do |exercise|
                            exercise.categories.add(cat)
                          end ) do
      yield
    end
  end

  def self.auto_categorize
    postprocess_exercise( lambda do |exercise|
                            categorize(exercise).each do |category|
                              exercise.categories.add(category)
                            end
                          end ) do
      yield
    end
  end

  def self.select
    ExercisePool::exercises.select do |exercise|
      yield exercise
    end
  end

  def self.pick(n)
    selection = ExercisePool::select do |exercise|
      yield exercise
    end

    if selection.length < n
    then abort "Only #{selection.length} exercises available!"
    else selection.pick(n)
    end
  end

  def self.all_categories
    result = Set.new

    exercises.each do |exercise|
      exercise.categories.items.each do |category|
        result.add(category)
      end
    end

    result
  end
end
