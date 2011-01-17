st = 1_000_000_000_000

# a/b * (a - 1)/(b - 1) = .5
# (a**2 - a)/(b**2 - b) = .5
# 2(a**2 - a)/(b**2 - b) = 1
# 2(a**2 - a) = b**2 - b
# a**2 - a = (b**2 - b)/2


b = st
while true
  eq = (b**2 - b)/2
  p eq

  exit if b == st + 20
  b += 1
end
