require 'mathn'

cnv = 100
cdigits = []
k = 1
while cdigits.length < cnv
  cdigits << 1
  cdigits << k*2
  cdigits << 1

  k += 1
end

rat = 3/2
1.upto 99 do |i|
  term = 1/(cdigits[i])
  rat = 1/(2+term)
  frac = 1+rat
  p frac
end

p rat
