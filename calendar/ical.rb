module ICal
  class Calendar
    def self.from_content_lines(content_lines)
      events = []
      current = nil

      content_lines.each do |content_line|
        case content_line
        when /^BEGIN:(.*)$/
        then
          if $1 == 'VEVENT'
          then
            abort "Nested BEGIN:VEVENT #{current}" if current
            current = []
          end
        when /^END:(.*)$/
        then
          if $1 == 'VEVENT'
          then
            abort "Unexpected END:VEVENT" unless current
            event = Event.from_content_lines(current)
            events.push(event)
            current = nil
          end
        else
          current.push(content_line) if current
        end
      end

      Calendar.new(events)
    end

    def self.from_lines(lines)
      content_lines = []

      lines.each do |line|
        if line =~ /^\s/
        then content_lines[-1] += $'.strip
        else content_lines.push line.strip
        end
      end

      Calendar.from_content_lines(content_lines)
    end

    def self.from_file(path)
      Calendar.from_lines( IO.readlines(path) )
    end

    def initialize(events)
      @events = events
    end

    def to_s
      @events.to_s
    end

    attr_reader :events

    def courses
      Calendar.new( @events.select do |event|
        event.course?
      end )
    end

    def which_groups
      events.map do |event|
        event.groups
      end.to_a.uniq
    end

    def sort
      Calendar.new( events.sort do |x, y|
                      x.start <=> y.start
                    end )
    end

    def select
      Calendar.new( events.select do |e|
                      yield e
                    end )
    end

    def each
      events.each do |x|
        yield x
      end
    end
  end

  class Event
    def self.from_content_lines(content_lines)
      properties = content_lines.map do |content_line|
        EventProperty.from_content_line(content_line)
      end

      Event.new(properties)
    end

    def initialize(properties)
      @properties = {}

      properties.each do |property|
        @properties[ property.name ] = property
      end
    end

    def [](property)
      @properties[property]
    end

    def to_s
      "Event #{self['SUMMARY'].value}"
    end

    def groups
      description = self['DESCRIPTION'].value

      abort "Cannot parse groups from #{description}" unless description =~ /Groepen:(.*?)Gemaakt/m

      result = $1
      result = result.gsub("\\n", "\n").strip
      result = result.gsub(/^MZ-/, "")

      result.lines.map do |line|
        line.strip
      end
    end

    def summary
      self['SUMMARY']
    end

    def description
      self['DESCRIPTION']
    end

    def course?
      self['CATEGORIES'] and self['CATEGORIES'].value == 'Lessenrooster'
    end

    def algo_theory?
      course? and summary.value =~ /MBI04a/ and description.value !~ /OEFENINGEN/
    end

    def algo_practice?
      course? and summary.value =~ /MBI04a/ and description.value =~ /OEFENINGEN/
    end

    def bop?
      course? and summary.value =~ /MBI08a/
    end

    def wiskunde?
      course? and summary.value =~ /MBI71a/
    end

    def dotnet?
      course? and summary.value =~ /MBI80x/
    end

    def start
      ICal::parse_datetime(self['DTSTART'].value)
    end

    def end
      ICal::parse_datetime(self['DTEND'].value)
    end
  end

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

      EventProperty.new(property_name, property_value, parameters)
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

    def to_s
      "#{@name}=#{@value}"
    end
  end


  def self.parse_datetime(string)
    if /(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})T(?<hour>\d{2})(?<minutes>\d{2})(?<seconds>\d{2})/ =~ string
    then DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minutes.to_i, seconds.to_i)
    else abort "Invalid datetime string #{string}"
    end
  end
end
