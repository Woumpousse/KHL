require './logica.rb'

def p1(b, j, k)
  j and not k
end

def p2(b, j, k)
  implies(b, k)
end

def p3(b, j, k)
  (not k) and (j or b)
end

def pp(*xs)
  p1(*xs) and p2(*xs) and p3(*xs)
end

def ppp(b, j, k)
  iff(b, not(p1(b,j,k))) and iff(j, not(p2(b,j,k))) and iff(k, not(p3(b,j,k)))
end

combinations(3).each do |x, y, z|
  xs = [x, y, z]

  puts( show(x,y,z,p1(*xs),p2(*xs),p3(*xs),ppp(*xs)) )
end
