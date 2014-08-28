require './Shared.rb'
require './HTML.rb'
require './Types.rb'
require './Java.rb'

module Questions

  class Expandable
    def initialize
      @properties = Hash.new
    end

    def method_missing(symbol, *args)
      Types.check( binding, { :symbol => Symbol } )

      if symbol.to_s.end_with? '='
      then
        abort unless args.length == 0
        arg = args[0]

        @properties[symbol] = arg
      else
        abort unless @properties.has_key? symbol

        @properties[symbol]
      end
    end
  end

  module FillInBlanksInCodeM
    class Fragment < Expandable
    end

    class Blank < Fragment
      def initialize(placeholder, solution)
        Types.check( binding, { :placeholder => String, :solution => String } )

        @placeholder = placeholder
        @solution    = solution
      end

      attr_reader :placeholder, :solution
    end

    class NonBlank < Fragment
      def initialize(text)
        Types.check( binding, { :text => String } )

        @text = text
      end
      
      attr_reader :text
    end

    class Question
      def initialize(data, formatter)
        Types.check( binding, { :data => String, :formatter => HTML::Formatters::Formatter } )

        @data = data
        @formatter = formatter
      end

      # Transforms @data into html
      def code
        str = ComposedString.from_string(@data)

        str = extract_blanks str
        str = extract_nonblanks str

        str.join do |fragment|
          process_fragment(fragment)
        end
      end

      protected
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

        if not data =~ /^([^:]*):([^:]*)$/
        then abort "Invalid blank specification: #{fragment}"
        else
          Blank.new($1, $2)
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

        HTML::blank_inputbox( blank.solution, blank.placeholder )
      end

      def process_nonblank(nonblank)
        Types.check( binding, { :nonblank => NonBlank } )

        @formatter.apply(nonblank.text)
      end
    end
  end

  class CodeFragment
    def initialize(string)
      @string = string
    end

    attr_reader :string
  end

  class SelectCodeFragments
    def initialize(code)
      @code = code
    end

    def code
      fragments.join do |fragment|
        process_fragment(fragment)
      end
    end

    protected
    def fragments
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
    def initialize(code, formatter)
      Types.check( binding, { :code => String, :formatter => HTML::Formatters::Formatter } )

      @code = code
      @formatter = formatter
    end

    def code
      @formatter.apply(@code)
    end
  end

  module Java
    # Basic Fill-In-Blanks question
    # Each input field has its own placeholder
    # Template syntax: __placeholder:solution__
    class FillInBlanks < Questions::FillInBlanksInCodeM::Question
      def initialize(data)
        super(data, HTML::Formatters::JavaFormatter.new)
      end

      def verify
        bundle = ::Java::Bundle.from_string( without_placeholders )

        ::Java::compile( bundle )
      end
    end

    # Fill-In-Blanks question
    # Each input field has the same placeholder
    # Template syntax: __solution__
    class HomogeneousFillInBlanks < FillInBlanks
      def initialize(data, placeholder)
        Types.check( binding, { :placeholder => String } )

        super(data)
        @placeholder = placeholder
      end

      protected
      def create_blank(data)
        Types.check( binding, { :data => String } )

        ::Questions::FillInBlanksInCodeM::Blank.new(@placeholder, data)
      end     
    end

    class FillInTypes < HomogeneousFillInBlanks
      def initialize(data)
        super(data, "type")
      end
    end

    class FillInAccessModifiers < HomogeneousFillInBlanks
      def initialize(data)
        super(data, "access modifier")
      end
    end

    class SelectTokens < SelectCodeFragments
      def initialize(code)
        super(code) # , /\w+(\[\])?(__)?*/)
      end

      def verify
      end

      protected
      def fragments
        result = ComposedString.from_string(@code)

        result = result.gsub(/(__.*?__)/) do |fragment|
          CodeFragment.new(fragment)
        end

        result = result.gsub(/(\w+(?:\[\])*)/) do |fragment|
          CodeFragment.new(fragment)
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

    class SelectLines < SelectCodeFragments
      def initialize(code)
        super(code)
      end

      def verify
      end

      protected
      def fragments
        result = ComposedString.from_string(@code)

        result = result.gsub(/(^.*$)/) do |fragment|
          CodeFragment.new(fragment)
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
      def initialize(code)
        super(code, HTML::Formatters::JavaFormatter.new)
      end

      def result
        bundle = ::Java::Bundle.from_string(@code)
        ::Java::run(bundle).strip
      end
    end
  end
end
