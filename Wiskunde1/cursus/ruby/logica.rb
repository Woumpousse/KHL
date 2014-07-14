def combinations(n)
  if n == 0
  then [[]]
  else
    combinations(n - 1).map do |xs|
      [ [false] + xs, [true] + xs ]
    end.flatten(1)
  end
end

def implies(p, q)
  not p or q
end

def iff(p, q)
  (p and q) or (not p and not q)
end

def xor(p, q)
  iff(p, not(q))
end

def show(*xs)
  xs.map do |x|
    if x then "1" else "0" end
  end.join(" & ") + ' \\\\'
end
