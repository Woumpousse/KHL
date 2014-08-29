require 'cgi'
require './Shared.rb'
require './Types.rb'
require './Java.rb'
require './JavaScript.rb'

module HTML
  module Formatters
    class Formatter
    end

    class RegexHighlighter < Formatter
      def initialize(regex, html_class)
        Types.check(binding, { :regex => Regexp, :html_class => String })

        @regex = regex
        @html_class = html_class
      end

      def apply(code)
        Types.check(binding, { :code => String })

        code.gsub(@regex) do |match|
          generate_element(match)
        end
      end

      def generate_element(data)
        Types.check(binding, { :data => String })

        "<span class=\"#{@html_class}\">#{data}</span>"
      end
    end

    class KeywordHighlighter < RegexHighlighter
      def initialize(keywords)
        Types.check(binding, { :keywords => [String] })

        super(Regexp.new("\\b(#{keywords.join('|')})\\b"), 'keyword')
      end
    end

    class LineCommentHighlighter < RegexHighlighter
      def initialize
        super(%r{//.*$}, 'comment')
      end
    end

    class BlockCommentHighlighter < RegexHighlighter
      def initialize
        super(%r{/\*.*?\*/}m, 'comment')
      end
    end

    class CombinedHighlighter < Formatter
      def initialize(formatters)
        Types.check(binding, { :formatters => [Formatter] })

        @formatters = formatters
      end

      def apply(code)
        Types.check(binding, { :code => String })

        result = code

        @formatters.each do |formatter|
          result = formatter.apply(result)
        end

        result
      end
    end

    class JavaFormatter < CombinedHighlighter
      def initialize    
        keyword_formatter = KeywordHighlighter.new(Java::KEYWORDS)
        line_comment_formatter = LineCommentHighlighter.new
        block_comment_formatter = BlockCommentHighlighter.new

        super( [keyword_formatter, line_comment_formatter, block_comment_formatter] )
      end
    end

    class JavaScriptFormatter < CombinedHighlighter
      def initialize    
        keyword_formatter = KeywordHighlighter.new(JavaScript::KEYWORDS)
        line_comment_formatter = LineCommentHighlighter.new
        block_comment_formatter = BlockCommentHighlighter.new

        super( [keyword_formatter, line_comment_formatter, block_comment_formatter] )
      end
    end

  end

  def HTML.unescape(value)
    CGI.unescapeHTML(value.to_s).gsub('"', '&quot;');
  end

  def HTML.string_of_attributes(attributes)
    Types.check( binding, { :attributes => { String => Types.any } } )

    attributes.keys.map do |key|
      value = attributes[key]
      value_string = unescape(value)

      "#{key}=\"#{value_string}\""
    end.join(" ")
  end

  def HTML.inputbox(attributes = {})
    attributes_string = string_of_attributes(attributes)

    "<input #{attributes_string}>"
  end

  def HTML.blank_inputbox(solution, placeholder="", validator="exact")
    HTML::inputbox( { 'data-solution' => solution,
                      'placeholder' => placeholder,
                      'data-validator' => validator
                    } )
  end

  def HTML.unordered_list(items, attributes = {})
    items_string = items.map do |item|
      "<li>#{unescape(item)}</li>"
    end.join("\n")

    attributes_string = string_of_attributes(attributes)

    <<-END
    <ul #{attributes_string}>
      #{items_string}
    </ul>
    END
  end
end
