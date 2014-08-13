require './Shared.rb'
require './HTML.rb'
require './Types.rb'

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

    def format_code_fragment(fragment)
      Types.check( binding, { :fragment => String } )

      @formatter.apply(fragment)
    end

    def format_input_element(data)
      Types.check( binding, { :data => String } )

      generate_input_element( { 'data-solution' => data } )
    end

    protected
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

  module Java
    class FillInBlanksInCode < Questions::FillInBlanksInCode
      def initialize(data)
        super(data, HTML::Formatters::JavaToHTML.new)
      end

      def verify
        bundle = Java::Bundle.from_string( without_placeholders )

        Java::compile( bundle )
      end
    end
  end
end
