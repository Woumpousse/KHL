require 'optparse'
require './Questions.rb'
require './Controller.rb'
require './Parameters.rb'
require './Generation.rb'

$latex_template = <<'END'
\documentclass[a4paper]{article}
\pagestyle{empty}

\begin{document}

%GSUB%

\end{document}
END

def parse_command_line_arguments
  options = {}

  optparse = OptionParser.new do |opts|
    opts.banner = "KHL Generator"

    options[:input] = nil
    opts.on( '-i', '--input FILE', 'Input html') do |file|
      options[:input] = file
    end

    options[:output] = nil
    opts.on( '-o', '--output FILE', 'Output html') do |file|
      options[:output] = file
    end

    options[:output] = nil
    opts.on( '-l', '--latex FILE', 'Output LaTeX') do |file|
      options[:latex] = file
    end

    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end

  optparse.parse!

  options
end


def process(input, output, latex)
  idx = -1
  entries = []

  result = IO.read(input).gsub(%r{<latex(.*?)>(.*?)</latex>}) do
    attributes, content = $1, $2

    idx += 1
    entries.push(content)

    "<img src=\"latex#{idx}.png\"#{attributes}></img>"
  end

  latex_result = $latex_template.gsub(/%GSUB%/) do
    entries.map do |entry|
      "\\[ #{entry} \\] \\clearpage"
    end.join
  end

  puts "Writing #{output}"
  File.open(output, "w") do |out|
    out.write(result)
  end

  puts "Writing #{latex}"
  File.open(latex, "w") do |out|
    out.write(latex_result)
  end
end



def main
  options = parse_command_line_arguments

  abort "Missing input file" unless options[:input]
  abort "Missing output file" unless options[:output]
  abort "Missing latex file" unless options[:latex]

  process(options[:input], options[:output], options[:latex])
end


main
