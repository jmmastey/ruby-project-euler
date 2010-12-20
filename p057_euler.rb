require 'mathn'

# this is conceptually simpler (and I understand it :P) but runs about 50x slower
# than the other version.

ct = 0
rat = 1/2
1000.times do
  rat = 1/(2+rat)
  frac = 1+rat

  if frac.numerator.to_s.length > frac.denominator.to_s.length
    #p frac
    ct += 1
  end
end

p ct
