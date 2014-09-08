require 'date'
require './ical.rb'
require './shared.rb'

module KHL
  MINIMUM_DATE = DateTime.new(2014, 9, 1)

  class Course
    def initialize(id)
      @id = id
    end

    def match?(event)
      event['CATEGORIES'] and event['CATEGORIES'].value == 'Lessenrooster'
    end

    def to_s
      @id
    end

    attr_reader :id
  end

  class Algo < Course
    def initialize(id)
      super
    end

    def match?(event)
      super and event.summary =~ /MBI04a/ 
    end
  end

  class AlgoTheory < Algo
    def initialize
      super('Algo Theory')
    end

    def match?(event)
      super and event.description !~ /OEFENINGEN/
    end
  end

  class AlgoExercises < Algo
    def initialize
      super('Algo Exercises')
    end

    def match?(event)
      super and event.description =~ /OEFENINGEN/
    end
  end

  class BOP < Course
    def initialize(id)
      super
    end

    def match?(event)
      super and event.summary =~ /MBI08a/
    end
  end

  class BOPTheory < BOP
    def initialize
      super('BOP Theory')
    end

    def match?(event)
      super and event.description !~ /OEFENINGEN/
    end
  end

  class BOPExercises < BOP
    def initialize
      super('BOP Exercises')
    end

    def match?(event)
      super and event.description =~ /OEFENINGEN/
    end
  end

  class DotNet < Course
    def initialize
      super('.NET')
    end

    def match?(event)
      super and event.summary =~ /MBI80x|MBI34a/
    end
  end

  class Wiskunde < Course
    def initialize(id)
      super
    end

    def match?(event)
      super and event.summary =~ /MBI71a/
    end
  end

  class WiskundeTheory < Wiskunde
    def initialize
      super('Wiskunde Theory')
    end

    def match?(event)
      super and event.location =~ /LESLOKAAL/
    end
  end

  class WiskundeExercises < Wiskunde
    def initialize
      super('Wiskunde Exercises')
    end

    def match?(event)
      super and event.location =~ /PC LLOKAAL|STUDIELANDSCHAP/
    end
  end

  class Event
    def initialize(course, event)
      @course = course
      @event = event
    end

    attr_reader :course, :event

    def group
      description = event.description

      abort "Cannot parse groups from #{description}" unless description =~ /Groepen:(.*?)Gemaakt/m

      result = $1
      result = result.gsub("\\n", "\n").strip
      result = result.gsub(/^MZ-/, "")

      result.lines.map do |line|
        line.strip
      end
    end

    def course_name
      @course.id
    end

    def start
      @event.start
    end

    def stop
      @event.end
    end

    def to_s
      format("%n (%g) %t %d")
    end

    def format(str)
      str.gsub("%n") do
        course_name
      end.gsub("%g") do
        group.join(",")
      end.gsub("%d") do
        start.strftime("%a %d/%m")
      end.gsub("%t") do
        start.strftime("%H:%M-") + stop.strftime("%H:%M")
      end
    end

    def <=>(other)
      event <=> other.event
    end
  end

  COURSES = [ AlgoTheory.new,
              AlgoExercises.new,
              BOPTheory.new,
              BOPExercises.new,
              DotNet.new,
              WiskundeTheory.new, 
              WiskundeExercises.new
            ]

  def self.identify(event)
    matches = COURSES.select do |course|
      course.match?(event)
    end

    case matches.length
    when 0
    then abort "#{event} matches no course"
    when 1
    then matches[0]
    else abort "#{event} has multiple matches!"
    end
  end

  def self.convert(ical_event)
    course = KHL::identify(ical_event)

    Event.new( course, ical_event )
  end
end

$cal = ICal::Calendar.from_file('calendar.ics')

$events = $cal.courses.between(DateTime.new(2014,9,1), DateTime.new(2015,9,1)).events.map do |event|
  KHL.convert(event)
end

def algo_theory
  $events.select do |event|
    KHL::AlgoTheory === event.course
  end
end

def algo_exercises
  $events.select do |event|
    KHL::AlgoExercises === event.course
  end
end

def groups(events)
  events.map do |event|
    event.group
  end.uniq
end

def for_group(events, group)
  events.select do |event|
    event.group == group
  end
end


def tex_template(course, group, schedule)
  <<-END.unindent
    \\documentclass[a4paper]{article}
    \\usepackage{booktabs}
    \\usepackage{a4wide}

    \\pagestyle{empty}

    \\newcommand{\\week}[3]{
      #1 & #2 & #3 \\\\
      \\hline
    }

    \\newenvironment{groupschedule}{
    }{
    }

    \\begin{document}
    \\begin{center}
      {\\Huge #{course}} \\\\[2mm]
      {\\Large #{group}} \\\\
      \\vfil\\large
      \\begin{tabular}{c|cc}
        \\bf Week & \\bf Theorie & \\bf Labo \\\\
        \\toprule
        #{schedule}
      \\end{tabular}
      \\vfil
    \\end{center}
    \\end{document}
  END
end


def algo
  theory = algo_theory.sort
  groups(algo_theory).map do |group|
    exercises = for_group( algo_exercises, group ).sort

    schedule = (0...12).map do |index|
      t = theory[index]
      e = exercises[index]

      <<-END.unindent
        \\week{#{index+1}}{#{t.format("%d %t")}}{#{e.format("%d %t")}}
      END
    end.join("\n")

    puts tex_template("Algo1", group.join(','), schedule)
  end
end


algo
