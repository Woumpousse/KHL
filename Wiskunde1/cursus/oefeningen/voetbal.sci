function b = breedte(l)
  b = 50 - l
end

function r = opp(l)
  r = breedte(l) * l
end

plot(0:50, opp)
