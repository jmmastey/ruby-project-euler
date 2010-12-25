require 'mathn'

low = 1/3
high = 1/2
lim = 12000

fractions = []
1.upto lim do |d|
  p d if 0 == d % 1000

  ns = (d*low).to_i
  t = (d*high).to_i
  ns.upto t do |n|
    f = n/d
    fractions << f
  end
end

p fractions.uniq.length
