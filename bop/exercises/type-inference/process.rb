module HTML
  class KeywordHighlighter
    def initialize(keywords)
      @keywords = keywords
    end

    def apply(code)
      regex = Regexp.new("\\b(#{@keywords.join('|')})\\b")

      code.gsub(regex) do |match|
        "<span class=\"keyword\">#{$1}</span>"
      end
    end
  end
end

def code_to_html(code)
  formatter = HTML::KeywordHighlighter.new(%w(public class static void))

  formatter.apply(code)
end

def partition_alternates(xs)
  result = [ [], [] ]

  xs.each_with_index do |x, i|
    result[i % 2].push(x)
  end

  result
end

def merge_alternates(xs, ys)
  result = []

  (0...[xs.length,ys.length].min).each do |i|
    result << xs[i]
    result << ys[i]
  end

  if xs.length > ys.length then
    result << xs[-1]
  end

  result
end

def to_html(source)
  fragments = source.split(/__(.*?)__/)

  code_fragments, input_fragments = partition_alternates(fragments)

  html_code_fragments = code_fragments.map { |code_fragment| code_to_html(code_fragment) }
  html_input_fragments = input_fragments.map do |input_fragment|
    "<input data-solution=\"#{input_fragment}\">"
  end

  merge_alternates(html_code_fragments, html_input_fragments).join
end

