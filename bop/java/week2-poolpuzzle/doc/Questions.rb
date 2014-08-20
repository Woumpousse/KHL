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
      fragments = @data.split(/__(.*?)__/)
      
      code_fragments, input_fragments = fragments.partition_alternates
      
      html_code_fragments = code_fragments.map do |code_fragment|
        format_code_fragment(code_fragment)
      end

      html_input_fragments = input_fragments.map do |input_fragment|
        format_input_element(input_fragment)
      end
      
      html_code_fragments.merge_alternates_with(html_input_fragments).join
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

  class SelectCodeFragments
    def initialize(code, regex)
      @code = code
      @regex = regex
    end

    def code
      find_fragments do |fragment|
        process_fragment(fragment)
      end
    end

    protected
    def find_fragments
      @code.gsub(@regex) do
        data = $1

        yield data
      end
    end

    def process_fragment(fragment)
      solution = if should_be_selected? fragment then 'true' else 'false' end
      stripped = strip_metadata(fragment)

      attributes = {
        'class' => 'selectable',
        'data-solution' => solution
      }

      generate_html_element(stripped, attributes)
    end

    def should_be_selected?(fragment)
      fragment.start_with?('%')
    end

    def strip_metadata(fragment)
      if fragment.start_with?('%')
      then fragment[1..-1]
      else fragment
      end
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
        abort "Invalid data #{data}" unless data =~ /^([^:]*):([^:]+)$/
        meta, solution = $1, $2

        { 'data-solution' => solution,
          'placeholder' => meta }
      end

      def pool
        @data.scan(/__(.*?)__/).map do |placeholder|
          placeholder = placeholder[0]
          abort "Invalid placeholder #{placeholder}" unless placeholder =~ /^([^:]*):([^:]+)$/
          $2
        end
      end

      def ul_pool
        entries = pool.map do |entry|
          "<li>#{entry}</li>"
        end.join("\n")

        "<ul>#{entries}</ul>"
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
        super(code, /(%?\w+)/)
      end

      def verify
      end
    end

    class SelectLines < SelectCodeFragments
      def initialize(code)
        super(code, /^(%?.+)$/)
      end

      def verify
      end

      protected
      def should_be_selected?(fragment)
        fragment.end_with?('<<')
      end

      def strip_metadata(fragment)
        if fragment =~ /\s*<<$/
        then $`
        else fragment
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
