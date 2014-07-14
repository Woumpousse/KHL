require './logica.rb'

def p1(k, b, m, s)
  implies(k, not(m))
end

def p2(k, b, m, s)
  iff(b, m)
end

def p3(k, b, m, s)
  not (s and b)
end

def pp(*xs)
  p1(*xs) and p2(*xs) and p3(*xs)
end

combinations(4).each do |k,b,m,s|
  xs = [k,b,m,s]

  puts( show(k,b,m,s,p1(*xs),p2(*xs),p3(*xs),pp(*xs)) )
end
