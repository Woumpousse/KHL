require './logica.rb'

# x = kok in keuken, ~x = kok in eetkamer
# y = butler in keuken, ~y = butler in eetkamer
# z = butler rookt sigaar


def p1(x, y, z)
  # x or y
  xor(x, y)
end

def p2(x, y, z)
  implies(z, not(y))
end

def p3(x, y, z)
  implies(x, not(z))
end

def pp(*xs)
  p1(*xs) and p2(*xs) and p3(*xs)
end

combinations(3).each do |x, y, z|
  xs = [x, y, z]

  puts( show(x,y,z,p1(*xs),p2(*xs),p3(*xs),pp(*xs)) )
end
