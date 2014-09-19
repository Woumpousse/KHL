def minify(str)
  str.gsub(%r{/\*.*?\*/}m, "").gsub(/\s{2,}/, ' ').gsub(/ ?(\W) ?/) do $1 end
end

puts minify(STDIN.read)
