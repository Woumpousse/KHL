require './Shared.rb'
require './HTML.rb'
require './Types.rb'
require './Java.rb'

module Questions
  class FillInBlanksInCode
    def initialize(data, formatter)
      Types.check( binding, { :data => String, :formatter => HTML::Formatters::Formatter } )

      @data = data
      @formatter = formatter
    end

    def code
      str = ComposedString.from_string(@data)

      str = str.gsub(/(__(?:.*?)__)/) do |fragment|
        Cell.new( format_input_element(fragment[2..-3]) )
      end

      str = str.gsub(/(.*)/) do |code|
        Cell.new( format_code_fragment(code) )
      end

      str.join do |cell|
        cell.contents
      end

#      fragments = @data.split(/__(.*?)__/) 

      
      # code_fragments, input_fragments = fragments.unthread
      
      # html_code_fragments = code_fragments.map do |code_fragment|
      #   format_code_fragment(code_fragment)
      # end

      # html_input_fragments = input_fragments.map do |input_fragment|
      #   format_input_element(input_fragment)
      # end
      
      # html_code_fragments.thread(html_input_fragments).join
    end

    protected
    def format_code_fragment(fragment)
      Types.check( binding, { :fragment => String } )

      @formatter.apply(fragment)
    end

    def format_input_element(data)
      Types.check( binding, { :data => String } )

      generate_input_element( extract_attributes_from_data(data) )
    end

    def extract_attributes_from_data(data)
      Types.check( binding, { :data => String } )

      { 'data-solution' => data }
    end

    def generate_input_element(attributes)
      Types.check( binding, { :attributes => { String => String } } )

      attributeString = attributes.to_a.map do |name, value|
        unescaped_data = CGI.unescapeHTML(value).gsub('"', '&quot;');

        "#{name}=\"#{unescaped_data}\""
      end.join(" ")

      "<input #{attributeString}>"
    end 

    private
    def without_placeholders
      @data.gsub(/__(.*?)__/) do
        $1
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
    class FillInBlanks < Questions::FillInBlanksInCode
      def initialize(data)
        super(data, HTML::Formatters::JavaFormatter.new)
      end

      def verify
        bundle = ::Java::Bundle.from_string( without_placeholders )

        ::Java::compile( bundle )
      end

      def extract_attributes_from_data(data)
        abort "Invalid data \"#{data}\"\nMust have form __placeholder:solution__" unless data =~ /^([^:]*):([^:]+)$/
        meta, solution = $1, $2

        { 'data-solution' => solution,
          'placeholder' => meta }
      end
    end

    class FillInTypes < FillInBlanks
      def initialize(data)
        super(data)
      end

      def extract_attributes_from_data(data)
        { 'data-solution' => data,
          'placeholder' => 'type' }
      end
    end

    class FillInLiterals < FillInBlanks
      def initialize(data)
        super(data)
      end

      def extract_attributes_from_data(data)
        { 'data-solution' => data,
          'placeholder' => 'literal' }
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
