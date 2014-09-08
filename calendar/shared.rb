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
end


class Array
  def zip_index(start = 0)
    (start ... start + length).zip self
  end
end
