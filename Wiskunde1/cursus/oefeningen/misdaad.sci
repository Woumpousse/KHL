function r = straal(z)
  r = (60 - 3 * z) / (2 * %pi)
end

function r = oppervlakte(z)
  r = z * z + %pi * straal(z)^2
end

plot(0:50, oppervlakte)
