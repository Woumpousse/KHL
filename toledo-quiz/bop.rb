require './Questions.rb'
require './Builder.rb'
require './LaTeX.rb'
require './Java.rb'

include Builder


module Questions

  class CodeFillInQuestion < Question
    NAME = 'fill-in'
    PLACEHOLDER_REGEX = /__(.*?)__/
    
    def initialize(template)
      Types.check(binding, { 'template' => String} )
      
      @template = template
      @question = create_question(template)
    end

    def check
      code = translate_to_java(@template)
      classes = Java.split_in_files(code)

      Java.compiles?(classes)
    end

    def toledo
      @question.toledo
    end

    def text
      @question.text
    end

    def answer
      @question.answers
    end

    def to_s
      @question.to_s
    end

    private
    def create_question(template)
      Types.check(binding, { 'template' => String} )

      case count_placeholders(template)
      when 0
        raise "No placeholder found"
      when 1
        create_question_single_placeholder(template)
      else
        create_question_multiple_placeholders(template)
      end
    end

    def create_question_single_placeholder(template)
      Types.check(binding, { 'template' => String} )

      answers = find_answers(template)    
      abort "Bug: More than one placeholder found" unless answers.length == 1

      answers = answers[0]
      
      text = translate_to_tex_single_placeholder(template)
      Questions::FillInQuestion.new(text, answers)
    end
    
    def find_answers(template)
      Types.check(binding, { 'template' => String} )      

      template.scan(PLACEHOLDER_REGEX).each do |match_array|
        match = match_array[0]
        match.split('|').map { |x| x.strip }
      end
    end

    def create_question_multiple_placeholders(template)
      raise "Unsupported"
    end

    def translate_to_java(template)
      Types.check(binding, { 'template' => String} )

      template.gsub(PLACEHOLDER_REGEX) do
        $1
      end.gsub(/\.\.\./, 'throw new RuntimeException();')
    end

    def translate_to_tex_single_placeholder(template)
      Types.check(binding, { 'template' => String} )

      template.gsub(PLACEHOLDER_REGEX) do
        '\placeholder'
      end.gsub(/\.\.\./, '\dots')
    end

    def translate_to_tex_multiple_placeholder(template)
      Types.check(binding, { 'template' => String} )

      k = 0
      template.gsub(PLACEHOLDER_REGEX) do
        "\\placeholdern{#{k}}"
        k += 1
      end
    end

    def count_placeholders(template)
      template.scan(PLACEHOLDER_REGEX).length
    end
  end
end



IO.read('bop/type-inference.question').scan(/^#(\S+)(.*?)(?=^#|\z)/m).each do |id, code|
    add_question( Questions::CodeFillInQuestion.new(code) )
end


puts tex(IO.read('bop.template.tex'))

