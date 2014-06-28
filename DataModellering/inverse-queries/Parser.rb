class Parser
  def self.parse_lines(lines)
    Parser.new(lines).result
  end

  def self.parse_file(filename)
    parse_lines(IO.readlines(filename))
  end

  def initialize(lines)    
    @result = []
    @current_hash = nil
    @current_attribute_name = nil
    @current_attribute_value = nil

    lines.map do |line|
      remove_comments(line).strip
    end.each_with_index do |line, index|
      process_line(line, index + 1)
    end

    close_attribute
    close_hash
  end

  attr_reader :result

  private
  def remove_comments(line)
    line.split("//")[0]
  end

  def process_line(line, line_number)
    if line.start_with? "#"
    then
      close_attribute
      close_hash
      start_hash(line[1..-1].strip, line_number)
    elsif line.start_with? "@"
    then
      close_attribute
      start_attribute(line[1..-1].strip)
    else
      append_to_value(line)
    end
  end

  def start_hash(name, line_number)
    @current_hash = Hash.new
    @current_hash[:name] = name
    @current_hash[:line] = line_number
  end

  def close_hash
    if @current_hash
    then
      @result.push(@current_hash)
      @current_hash = nil
    end
  end

  def start_attribute(name)
    @current_attribute_name = name
    @current_attribute_value = []
  end

  def append_to_value(data)    
    @current_attribute_value.push(data) if @current_attribute_value
  end

  def close_attribute
    if @current_attribute_name
      @current_hash[@current_attribute_name] = @current_attribute_value
      @current_attribute_name = nil
      @current_attribute_value = nil
    end
  end
end
