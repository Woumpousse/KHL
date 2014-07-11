require './Questions.rb'
require './Builder.rb'
require './LaTeX.rb'
require './Java.rb'

include Builder


module Questions

end



IO.read('bop/type-inference.question').scan(/^#(\S+)(.*?)(?=^#|\z)/m).each do |id, code|
    add_question( Questions::CodeFillInQuestion.new("Vul geldige types in.", code) )
end


puts tex(IO.read('bop.template.tex'))

