require 'date'
require './ical.rb'
require './shared.rb'

FILE = 'calendar.ics'
# FILE = 'merel.ics'

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
      super and event.summary =~ /MBI71a|Wiskunde/
    end
  end

  class WiskundeTheory < Wiskunde
    def initialize
      super('Wiskunde Theory')
    end

    def match?(event)
      super and event.location =~ /LESLOKAAL/ and event.location !~ /318/
    end
  end

  class WiskundeExercises < Wiskunde
    def initialize
      super('Wiskunde Exercises')
    end

    def match?(event)
      super and event.location =~ /PC LLOKAAL|STUDIELANDSCHAP|318/
    end
  end

  class DistributedApplications < Course
    def initialize
      super('Distributed Applications')
    end

    def match?(event)
      super and event.summary =~ /MBI63a/
    end
  end

  class DataModellering < Course
    def initialize
      super('Datamodellering')
    end

    def match?(event)
      super and event.summary =~ /MBI70a/
    end
  end

  class ServiceOrientedArchitectures < Course
    def initialize
      super('SOA')
    end

    def match?(event)
      super and event.summary =~ /MBI44a/
    end
  end

  class OOO < Course
    def initialize(id)
      super
    end

    def match?(event)
      super and event.summary =~ /MBI51x/
    end
  end

  class OOOTheory < OOO
    def initialize
      super('OOO Theory')
    end

    def match?(event)
      super and event.description !~ /oefeningen/
    end
  end

  class OOOExercises < OOO
    def initialize
      super('OOO Exercises')
    end

    def match?(event)
      super and event.description =~ /oefeningen/
    end
  end

  class Session
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

    def theory?
      /Theory/ =~ course_name
    end

    def exercises?
      /Exercises/ =~ course_name
    end

    def location
      case @event.location
      when /(\d+{3}) - (LESLOKAAL|PC LLOKAAL)/
      then "GT#{$1}"
      when /STUDIELANDSCHAP/
      then "GT107"
      else @event.location
      end
    end

    def start
      @event.start
    end

    def stop
      @event.stop
    end

    def to_s
      format("%n (%g) %t %d")
    end

    def format(str, week_mapping = nil)
      str.gsub("%n") do
        course_name
      end.gsub("%g") do
        group.join(",")
      end.gsub("%w") do
        week_mapping[ start.cweek ]
      end.gsub("%d") do
        start.strftime("%a %d/%m")
      end.gsub("%T") do
        if theory?
        then 'T'
        else 'E'
        end
      end.gsub("%l") do
        location
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
              WiskundeExercises.new,
              DistributedApplications.new,
              DataModellering.new,
              ServiceOrientedArchitectures.new,
              OOOTheory.new,
              OOOExercises.new
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

    Session.new( course, ical_event )
  end
end

def sweeks_map(sessions)
  cweeks = sessions.map do |session|
    session.event.cweek
  end.sort.uniq

  abort "Insufficient weeks: found #{cweeks.length}, expected 12" unless cweeks.length == 12

  Hash[ cweeks.zip(1..12) ]
end


$cal = ICal::Calendar.from_file(FILE)

$events = $cal.courses.between(DateTime.new(2014,9,1), DateTime.new(2015,9,1)).events.map do |event|
  KHL.convert(event)
end.sort

$week_mapping = sweeks_map($events)

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

def wiskunde_all
  $events.select do |event|
    KHL::Wiskunde === event.course
  end
end

def wiskunde_theory
  $events.select do |event|
    KHL::WiskundeTheory === event.course
  end
end

def wiskunde_exercises
  $events.select do |event|
    KHL::WiskundeExercises === event.course
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

def each_group(events)
  groups(events).each do |group|
    yield group, for_group(events, group)
  end
end

def print_course(course)
  series = $events.select do |session|
    course === session.course
  end

  each_group(series) do |group, sessions|
    puts "#{course.new.id} #{group.join(',')}"
    print_series(sessions)
    puts
  end
end

def print_series(series)
  series.each_with_index do |session, index|
    index_string = sprintf("%2d", index + 1)
    week_string = sprintf("%2d", $week_mapping[session.start.cweek])
    puts session.format("[#{index_string}|#{week_string}] %d %t %l", $week_mapping)
  end
end

def html_series(series)
  series.each_with_index do |session, index|
    index_string = sprintf("%2d", index + 1)
    week_string = sprintf("%2d", $week_mapping[session.start.cweek])
    puts session.format("<tr><td>#{index_string}</td><td>#{week_string}</td><td>%d %t</td><td></td>", $week_mapping)
  end
end




def wiskunde
  all = wiskunde_all.sort
  
  groups(all).each do |group|
    gs = group.join(",")

    sessions = for_group(all, group).sort    

    theory = sessions.select do |session|
      session.theory?
    end

    exercises = sessions.select do |session|
      session.exercises?
    end

    if theory.size < 2
      theory = []
      exercises = []

      (0...sessions.length).each do |i|
        if i.even?
        then theory
        else exercises
        end.push(sessions[i])
      end
    end

    puts "Theorie #{gs}"

    print_series(theory)

    puts
    puts "Oefeningen #{gs}"

    print_series(exercises)
    puts
  end
end

def bop
  print_course(KHL::BOPTheory)
  print_course(KHL::BOPExercises)
end

def algo
  print_course(KHL::AlgoTheory)
  print_course(KHL::AlgoExercises)
end

