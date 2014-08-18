class Array
  def pick(n)
    (0..length-1).to_a.shuffle[0..n-1].map do |i|
      self[i]
    end
  end
end


class String
  def indent(n = 2)
    lines.map { |s| (" " * n) + s }.join
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
