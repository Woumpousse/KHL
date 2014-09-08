require 'date'
require './ical.rb'

module KHL
  MINIMUM_DATE = DateTime.new(2014, 9, 1)

  class Course
    def match?(event)
      event['CATEGORIES'] and event['CATEGORIES'].value == 'Lessenrooster'
    end
  end

  class Algo < Course
    def match?(event)
      super and event.summary =~ /MBI04a/ 
    end
  end

  class AlgoTheory < Algo
    def match?(event)
      super and event.description !~ /OEFENINGEN/
    end
  end

  class AlgoExercise < Algo
    def match?(event)
      super and event.description =~ /OEFENINGEN/
    end
  end

  class BOP < Course
    def match?(event)
      super and event.summary =~ /MBI08a/
    end
  end

  class BOPTheory < BOP
    def match?(event)
      super and event.description !~ /OEFENINGEN/
    end
  end

  class BOPExercise < BOP
    def match?(event)
      super and event.description =~ /OEFENINGEN/
    end
  end

  class DotNet < Course
    def match?(event)
      super and event.summary =~ /MBI80x|MBI34a/
    end
  end

  class Wiskunde < Course
    def match?(event)
      super and event.summary =~ /MBI71a/
    end
  end

  class WiskundeTheory < Wiskunde
    def match?(event)
      super and event.location =~ /LESLOKAAL/
    end
  end

  class WiskundeExercise < Wiskunde
    def match?(event)
      super and event.location =~ /PC LLOKAAL|STUDIELANDSCHAP/
    end
  end

  COURSES = [ AlgoTheory.new,
              AlgoExercise.new,
              BOPTheory.new,
              BOPExercise.new,
              DotNet.new,
              WiskundeTheory.new, 
              WiskundeExercise.new
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
end



$cal = ICal::Calendar.from_file('calendar.ics')


$cal.courses.between(DateTime.new(2014,9,1), DateTime.new(2015,9,1)).each do |event|
  puts KHL.identify(event)
end

# $cal.select do |event|
#   event.algo_practice?
# end.sort.each do |event|
#   puts event.start.strftime("%W %d/%m"), event.summary, event.groups
# end
