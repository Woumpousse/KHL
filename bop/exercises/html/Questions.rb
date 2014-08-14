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

    def html
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
        unescaped_data = CGI.unescapeHTML(value)

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
    def initialize(code)
      @code = code
    end

    def html
      find_fragments(@code) do |fragment|
        process_fragment(fragment)
      end
    end

    protected
    def find_fragments(code)
      code.gsub(/(%?\w+)/) do
        data = $1

        yield data
      end
    end

    def process_fragment(fragment)
      if fragment.start_with?("%")
      then
        fragment = fragment[1..-1]
        solution = 'true'
      else
        solution = 'false'
      end

      attributes = {
        'class' => 'selectable',
        'data-solution' => solution
      }

      generate_html_element(fragment, attributes)
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

  module Java
    class FillInBlanksInCode < Questions::FillInBlanksInCode
      def initialize(data)
        super(data, HTML::Formatters::JavaToHTML.new)
      end

      def verify
        bundle = ::Java::Bundle.from_string( without_placeholders )

        ::Java::compile( bundle )
      end
    end

    class TypeInference < FillInBlanksInCode
      def initialize(data)
        super(data)
      end

      def extract_attributes_from_data(data)
        attributes = super

        attributes['placeholder'] = 'type'

        attributes
      end
    end

  end
end
