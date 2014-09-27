IO.read($target).remove_comments.scan(/^#(\S+)\[(.*?)\](.*?)(?=^#|\z)/m).each do |type, metadata, code|
  scope do
    metadata.split(',').each do |metadatum|
      key, val = metadatum.split('=')
      set(key, val)
    end

    case type
    when "infer-types"
    then add_question( Questions::CodeFillInQuestion.new("Vul geldige types in.", code.strip_empty_lines) )
    when "interpret-code"
    then add_question( Questions::InterpretCodeQuestion.new("Wat is de uitvoer van dit programma?", code.strip_empty_lines) )
    else abort "Unrecognized question type #{type}"
    end
  end
end


case $command
when "tex"
then puts tex(IO.read('bop.template.tex'))
when "toledo"
then puts( toledo { |idx| idx.to_s } )
when "check"
then check
else abort "Unrecognized command"
end
