require './Shared.rb'
require './HTML.rb'
require './Types.rb'
require './Java.rb'
require './JavaScript.rb'

module Questions
  def self.remove_redundant_whitespace(code)
    Types.check( binding, { :code => String } )

    result = []
    last_line_empty = false

    code.lines.each do |line|
      if line.strip.empty? and not last_line_empty
      then
        last_line_empty = true
        result.push('')
      else
        last_line_empty = false
        result.push(line.strip)
      end
    end

    result.join("\n").strip
  end
  
  class Expandable
    def initialize
      @properties = Hash.new
    end

    def method_missing(symbol, *args)
      Types.check( binding, { :symbol => Symbol } )

      if symbol.to_s.end_with? '='
      then
        abort "Bug" unless args.length == 1
        arg = args[0]

        @properties[symbol.to_s[0..-2].to_sym] = arg
      else
        raise "Unknown property #{symbol.to_s}" unless @properties.has_key? symbol

        @properties[symbol]
      end
    end
  end

  class Question < Expandable
  end

  def Questions::build_question(question=nil)
    question = (question or Question.new)
    yield question
    question
  end

  class FillInBlanksInCode
    class Fragment < Expandable
    end

    class Blank < Fragment
      def initialize(placeholder, solution, validator)
        Types.check( binding, { :placeholder => String, :solution => String, :validator => String } )

        @placeholder = placeholder
        @solution    = solution
        @validator   = validator
      end

      attr_reader :placeholder, :solution, :validator
    end

    class NonBlank < Fragment
      def initialize(text)
        Types.check( binding, { :text => String } )

        @text = text
      end
      
      attr_reader :text
    end

    def initialize(formatter)
      Types.check( binding, { :formatter => HTML::Formatters::Formatter } )

      @formatter = formatter
    end

    def parse(string)
      Types.check( binding, { :string => String } )

      composed_string = decompose_string(string)


      ::Questions.build_question do |q|
        q.code =  composed_string.join do |fragment|
          process_fragment(fragment)
        end

        q.answers = collect_answers(composed_string)
      end
    end

    protected
    # Turns the string into a composed string built out of Blank and NonBlanks
    def decompose_string(string)
      Types.check( binding, { :string => String } )

      str = ComposedString.from_string(string)

      str = extract_blanks str
      str = extract_nonblanks str

      str
    end

    def collect_blanks(composed_string)
      Types.check( binding, { :composed_string => ComposedString } )

      composed_string.to_a.select do |part|
        Blank === part
      end
    end

    def collect_answers(composed_string)
      Types.check( binding, { :composed_string => ComposedString } )

      collect_blanks(composed_string).map do |blank|
        blank.solution
      end
    end

    # Finds the blanks in str and replaces them by Blank objects
    def extract_blanks(str)
      Types.check( binding, { :str => ComposedString } )

      str.gsub(/(__(?:.*?)__)/) do |fragment|
        create_blank(fragment[2..-3])
      end       
    end

    # Receives text between __ __ and wraps it into a Blank object
    def create_blank(data)
      Types.check( binding, { :data => String } )

      case data
      when /^([^`]*)`([^`]*)`([^`]*)$/
      then 
        placeholder, solution, validator = $1, $2, $3

        if validator == ''
        then validator = 'exact'
        end

        Blank.new(placeholder, solution, validator)
      else raise "Invalid blank specification: #{data}"
      end
    end

    # Called after extract_blanks. Is given the rest of the string
    # and deals with the nonblank parts.
    def extract_nonblanks(str)
      Types.check( binding, { :str => ComposedString } )

      str.gsub(/(.*)/) do |text|
        NonBlank.new(text)
      end
    end

    # Given a Blank or NonBlank
    def process_fragment(fragment)
      Types.check( binding, { :fragment => Fragment } )

      if Blank === fragment
      then process_blank(fragment)
      else process_nonblank(fragment)
      end
    end

    def process_blank(blank)
      Types.check( binding, { :blank => Blank } )

      HTML::blank_inputbox( blank.solution, blank.placeholder, blank.validator )
    end

    def process_nonblank(nonblank)
      Types.check( binding, { :nonblank => NonBlank } )

      @formatter.apply(nonblank.text)
    end
  end


  class SelectCodeFragments
    class CodeFragment
      def initialize(string)
        @string = string
      end
      
      attr_reader :string
    end

    def parse(code)
      ::Questions.build_question do |q|
        q.code = fragments(code).join do |fragment|
          process_fragment(fragment)
        end
      end
    end

    protected
    def fragments(code)
      abort "Left undefined; should be overriden in subclasses"
    end

    def process_fragment(fragment)
      solution = if should_be_selected? fragment then 'true' else 'false' end
      stripped = strip(fragment)

      attributes = {
        'class' => 'selectable',
        'data-solution' => solution
      }

      generate_html_element(stripped, attributes)
    end

    def should_be_selected?(fragment)
      abort "Left undefined; should be overriden in subclasses"
    end

    def strip(fragment)
      abort "Left undefined; should be overriden in subclasses"
    end

    def generate_html_element(fragment, attributes)
      Types.check( binding, { :attributes => { String => String } } )

      attributeString = attributes.to_a.map do |name, value|
        unescaped_data = CGI.unescapeHTML(value)

        "#{name}=\"#{unescaped_data}\""
      end.join(" ")

      "<span #{attributeString}>#{fragment}</span>"
    end
  end



  class InterpretCode
    def initialize(formatter)
      Types.check( binding, { :formatter => HTML::Formatters::Formatter } )

      @formatter = formatter
    end

    def parse(code)
      Types.check( binding, { :code => String } )

      ::Questions.build_question do |q|
        view_code = remove_hidden_code(code)
        view_code = ::Questions::remove_redundant_whitespace(view_code)

        q.code = @formatter.apply( view_code )
      end
    end

    protected
    module QuestionExtension
      def output_key(k)
        if output =~ /^#{k}=(.*)$/
        then $1
        else raise "Key not found in output"
        end
      end

      def output_map
        result = {}

        output.scan(/^([^=]+)=([^=]+)$/).each do |key, val|
          result[key.strip] = val.strip
        end

        result
      end
    end

    def hide_by_tags(code)
      Types.check( binding, { :code => String } )

      code.gsub(/`([^:]+):([^`]*)`/) do
        tag, body = $1, $2

        if yield tag
        then ""
        else body
        end
      end
    end

    def remove_hidden_code(code)
      Types.check( binding, { :code => String } )

      hide_by_tags(code) do |tag|
        tag == 'hide'
      end
    end

    def remove_tags(code)
      Types.check( binding, { :code => String } )

      hide_by_tags(code) do
        false
      end
    end
  end


  module Java
    # Basic Fill-In-Blanks question
    # Each input field has its own placeholder
    # Template syntax: __placeholder:solution__
    class FillInBlanks < ::Questions::FillInBlanksInCode
      def initialize
        super( HTML::Formatters::JavaFormatter.new )
      end
    end

    # Fill-In-Blanks question
    # Each input field has the same placeholder
    # Template syntax: __solution__
    class HomogeneousFillInBlanks < FillInBlanks
      def initialize(placeholder, validator)
        super()

        Types.check( binding, { :placeholder => String, :validator => String } )

        @placeholder = placeholder
        @validator   = validator
      end

      protected
      def create_blank(data)
        Types.check( binding, { :data => String } )

        ::Questions::FillInBlanksInCode::Blank.new(@placeholder, data, @validator)
      end     
    end

    class FillInTypes < HomogeneousFillInBlanks
      def initialize
        super("type", 'exact')
      end
    end

    class FillInAccessModifiers < HomogeneousFillInBlanks
      def initialize
        super("access modifier", 'exact')
      end
    end

    class SelectTokens < ::Questions::SelectCodeFragments
      protected
      def fragments(code)
        result = ComposedString.from_string(code)

        result = result.gsub(/(__.*?__)/) do |fragment|
          ::Questions::SelectCodeFragments::CodeFragment.new(fragment)
        end

        result = result.gsub(/(\w+(?:\[\])*)/) do |fragment|
          ::Questions::SelectCodeFragments::CodeFragment.new(fragment)
        end

        result
      end

      def should_be_selected?(fragment)
        fragment.string.start_with?('__') and fragment.string.end_with?('__')
      end

      def strip(fragment)
        if should_be_selected? fragment
        then fragment.string[2..-3]
        else fragment.string
        end
      end
    end

    class SelectLines < ::Questions::SelectCodeFragments
      protected
      def fragments(code)
        result = ComposedString.from_string(code)

        result = result.gsub(/(^.*$)/) do |fragment|
          ::Questions::SelectCodeFragments::CodeFragment.new(fragment)
        end

        result
      end

      def should_be_selected?(fragment)
        fragment.string.end_with?('<<')
      end

      def strip(fragment)
        if should_be_selected? fragment
        then fragment.string[0..-3]
        else fragment.string
        end
      end
    end

    class InterpretCode < ::Questions::InterpretCode
      def initialize
        super(HTML::Formatters::JavaFormatter.new)
      end

      def parse(code)
        ::Questions::build_question(super(code)) do |q|
          q.output = compute_result(code)
        end
      end

      protected
      def compute_result(code)
        bundle = ::Java::Bundle.from_string(code)
        ::Java::run(bundle).strip
      end
    end
  end

  module JavaScript
    class InterpretCode < ::Questions::InterpretCode
      def initialize
        super(HTML::Formatters::JavaScriptFormatter.new)
      end

      def parse(code)
        ::Questions::build_question(super(code)) do |q|
          q.output = compute_result(remove_tags(code))
          q.extend QuestionExtension
        end
      end

      protected
      def compute_result(code)
        ::JavaScript.run(code).strip
      end
    end
  end
end
