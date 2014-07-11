require './Questions.rb'
require './Builder.rb'
require './LaTeX.rb'
require './Java.rb'
require './Shared.rb'

include Builder



IO.read('bop/type-inference.question').scan(/^#(\S+)(.*?)(?=^#|\z)/m).each do |id, code|
    add_question( Questions::CodeFillInQuestion.new("Vul geldige types in.", code.strip_empty_lines) )
end

abort "Fails to check" unless check

puts tex(IO.read('bop.template.tex'))

