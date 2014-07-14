require './logica.rb'

def p1(a, b, c)
  implies(not(a), b)
end

def p2(a, b, c)
  implies(c, implies(not(a), not(b)))
end

def p3(a, b, c)
  not c
end

def pp(*xs)
  implies((p1(*xs) and p2(*xs)), p3(*xs))
end

combinations(3).each do |x, y, z|
  xs = [x, y, z]

  puts( show(x,y,z,p1(*xs),p2(*xs),p3(*xs),pp(*xs)) )
end
