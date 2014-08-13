require 'cgi'
require './Shared.rb'
require './Types.rb'

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
        super(%r{/\*.*?\*/}, 'comment')
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

    class JavaToHTML < CombinedHighlighter
      KEYWORDS = %w(abstract assert boolean break byte case catch char class const continue default do double else enum extends final finally float for goto if implements import instanceof int interface long native new package private protected public return short static strictfp super switch synchronized this throw throws transient try void volatile while false null true)

      def initialize    
        keyword_formatter = KeywordHighlighter.new(KEYWORDS)
        line_comment_formatter = LineCommentHighlighter.new
        block_comment_formatter = BlockCommentHighlighter.new

        super( [keyword_formatter, line_comment_formatter, block_comment_formatter] )
      end
    end
  end

end
