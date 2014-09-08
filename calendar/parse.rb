class EventProperty
  def self.from_content_line(content_line)
    abort "Invalid content line #{content_line}" unless content_line =~ /^([^:;]+)(;[^:]+)*:(.*)$/

    property_name = $1
    property_parameters = $2
    property_value = $3

    if not property_parameters or property_parameters.empty?
    then parameters = {}
    else parameters = Hash[ property_parameters.split(/(?<!\\);/)[1..-1].map do |pair|
                              abort "Invalid parameter '#{pair}' in #{property_parameters}" unless pair =~ /^([^=]+)=(.+)$/
                              parameter_name, parameter_value = $1, $2
                              [ parameter_name, parameter_value ]
                            end ]
    end

    Property.new(property_name, property_value, parameters)
  end

  def initialize(name, value, parameters)
    @name = name
    @value = value
    @parameters = parameters
  end

  attr_reader :name, :value

  def [](parameter)
    @parameters[parameter]
  end
end

class Event
  def self.from_content_lines(content_lines)
    properties = content_lines.map do |content_line|
      EventProperty.from_content_line(content_line)
    end

    Event.new(properties)
  end
end

def content_lines(lines)
  result = []

  lines.each do |line|
    if line =~ /^\s/
    then result[-1] += $'.strip
    else result.push line.strip
    end
  end

  result
end

def parse_events(content_lines)
  result = []
  current = nil

  content_lines.each do |content_line|
    case content_line
    when /^BEGIN:(.*)$/
    then
      if $1 == 'VEVENT'
      then
        abort "Nested BEGIN:VEVENT" if current
        current = {}
      end
    when /^END:(.*)$/
    then
      if $1 == 'VEVENT'
      then
        abort "Unexpected END:VEVENT" unless current
        result.push(current)
        current = nil
      end
    when /^([^:;]+)(;[^:]+)*:(.*)$/
    then
      if current then
        property_name = $1
        property_parameters = $2
        property_value = $3

        if not property_parameters or property_parameters.empty?
        then hash = {}
        else hash = Hash[ property_parameters.split(/(?<!\\);/)[1..-1].map do |pair|
                            abort "Invalid parameter '#{pair}' in #{property_parameters}" unless pair =~ /^([^=]+)=(.+)$/
                            parameter_name, parameter_value = $1, $2
                            [ parameter_name, parameter_value ]
                          end ]
        end
        
        hash[:value] = property_value

        current[property_name] = hash
      end
    else
      puts "Unrecognized content line #{content_line}"
    end
  end
  result
end

def parse_datetime(string)
  if string =~ /(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})T(?<hour>\d{2})(?<minutes>\d{2})(?<seconds>\d{2})/
  then DateTime.new(year, month, day, hour, minutes, seconds)
  else abort "Invalid datetime string #{string}"
  end
end

def find_courses(events, course_regex)
  events.select do |event|
    event['CATEGORIES'] and event['CATEGORIES'][:value] == 'Lessenrooster' and event['DESCRIPTION'] and event['DESCRIPTION'][:value] =~ course_regex
end
end


$content_lines = content_lines( IO.readlines('calendar.ics') )

$events = parse_events($content_lines)

find_courses($events, /MBI04a/).each do |event|
  puts event['LOCATION'][:value]
end
