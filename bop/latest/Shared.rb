module Enumerable
  def intersperse(item)
    map do |elt|
      [ item, elt ]
    end.flatten(1).drop(1)
  end
end

class Array
  def drop_while
    index = find_index do |x|
      not (yield x)
    end

    self[index..-1]
  end  

  def unthread
    result = [ [], [] ]

    each_with_index do |x, i|
      result[i % 2].push(x)
    end

    result
  end

  def thread(ys)
    xs = self
    result = []

    (0...[xs.length, ys.length].min).each do |i|
      result << xs[i]
      result << ys[i]
    end

    if xs.length > ys.length then
      result << xs[-1]
    end

    result
  end
end

class String
  def indent(indentation=2)
    lines.map do |line|
      " " * indentation + line
    end.join
  end

  def unindent(indentation = nil)
    unless indentation
      indentation = lines.select do |line|
        line.strip.length > 0
      end.map do |line|
        line =~ /^( *)/
        currentIndentation = $1.length

        currentIndentation
      end.min
    end

    lines.map do |line|
      if line.strip.length > 0
      then line[indentation..-1]
      else line
      end
    end.join
  end

  def remove_comments
    gsub(/#<.*?>#/m, "")
  end

  def strip_empty_lines
    lines.drop_while do |line|
      line.strip.empty?
    end.reverse.drop_while do |line|
      line.strip.empty?
    end.reverse.join
  end
end

class Lazy
  def initialize(&block)
    @evaluator = block
    @value = nil
    @evaluated = false
  end

  def value
    if not @evaluated
    then
      @value = @evaluator[]
      @evaluated = true
    end

    @value
  end
end

class ComposedString
  def self.from_string(string)
    ComposedString.new([string])
  end

  def initialize(components)
    @components = components.dup
  end

  # IMPORTANT
  # regex must have one capturing group encompassing the entire match
  # otherwise split will not work correctly
  # Noncapturing groups: (?:regex)
  def gsub(regex)
    result = @components.map do |component|
      if component.is_a? String
      then
        strings, captured = component.split(regex).unthread
        transformed_captured = captured.map { |x| yield x }
        strings.thread(transformed_captured)
      else
        [component]
      end
    end.flatten(1)
    
    ComposedString.new(result)
  end
  
  def join(infix='')
    @components.map do |component|
      if component.is_a? String
      then component
      else yield component
      end
    end.join(infix)
  end
  
  def to_a
    @components.dup
  end
end

class Token
  def initialize(str)
    @str = str
  end
  
  def to_s
    @str
  end
end

$cs = ComposedString.from_string('Hello world there')
$cs2 = $cs.gsub(/(\w+)/) do |match|
  Token.new(match)
end
