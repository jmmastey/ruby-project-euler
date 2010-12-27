require 'mathn'

low = 1/3
high = 1/2
lim = 12_000
sum = 0

fractions = { 0 => nil, 1/2 => nil, 1/3 => nil }
1.upto lim do |d|
  p d if 0 == d % 100

  ns = (d*low).ceil
  t = (d*high).to_i
  ns.upto t do |n|
    f = n/d
    next if fractions.include? f
    next unless f > low
    next unless f < high

    fractions[f] = nil
    sum += 1
  end
end

p sum
