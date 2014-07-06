require './Shared.rb'

module Parser
  # A section starts with unindented text, followed by indented text
  def Parser.sections(string)
    string.scan(/^\S.*?(?=^\S|\z)/m).map do |section|
      lines = section.lines.to_a

      [ lines[0].strip, lines[1..-1].join.unindent ]
    end
  end

  def Parser.parse_string(string, raw=false)
    sections(string).map do |name, data|
      result = { :name => name }

      sections(data).each do |key, val|
        result[key] = if raw
                      then
                        val
                      else
                        val.strip_empty_lines.unindent
                      end
      end

      result
    end
  end

  def Parser.parse_file(filename, raw=false)
    parse_string(IO.read(filename), raw)
  end
end
