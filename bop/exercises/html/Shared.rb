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

  def partition_alternates
    result = [ [], [] ]

    each_with_index do |x, i|
      result[i % 2].push(x)
    end

    result
  end

  def merge_alternates_with(ys)
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
      line[indentation..-1]
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

class Module
  def class_names
    constants.select do |constant|
      Class === const_get(constant)
    end
  end

  def classes
    class_names.map do |name|
      const_get(name)
    end
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

