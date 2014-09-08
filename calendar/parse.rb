require 'date'
require './ical.rb'

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

    def groups
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

    def date
      @event.start.strftime("%a %d %b")
    end

    def to_s
      "#{course_name} (#{groups.join(",")}), #{date}"
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

$courses = $cal.courses.between(DateTime.new(2014,9,1), DateTime.new(2015,9,1)).events.map do |event|
  KHL.convert(event)
end

puts $courses

# $cal.select do |event|
#   event.algo_practice?
# end.sort.each do |event|
#   puts event.start.strftime("%W %d/%m"), event.summary, event.groups
# end
