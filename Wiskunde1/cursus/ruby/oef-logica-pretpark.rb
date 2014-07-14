require './logica.rb'

def p1(p, q, r)
  p and not(q) and not(r)
end

def p2(p, q, r)
  not p or q or r
end

def pp(*xs)
  p1(*xs) and p2(*xs)
end


combinations(3).each do |x, y, z|
  xs = [x, y, z]

  puts( show(x,y,z,p1(*xs),p2(*xs),pp(*xs)) )
end
