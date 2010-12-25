require 'mathn'
require 'tools'

def fractional(m, d, a, a0, s)
  mp = d*a-m
  dp = (s-mp**2)/d
  ap = ((a0+mp)/dp).floor

  [mp, dp, ap, a0, s]
end

def fractionals_for_sqrt n
  fractionals = []
  m = 0
  d = 1
  a = a0 = (n**0.5).floor

  while true
    res = fractional(m, d, a, a0, n)
    p res
    break if fractionals.include? res

    fractionals << res
    m, d, a = res[0], res[1], res[2]
  end

  fractionals
end

limit = 10_000
odds = 0
2.upto limit do |n|
  next if 0 == n**0.5%1 # m^2

  period = fractionals_for_sqrt(n).length
  odds += 1 if period%2 == 1
end

puts "there are #{odds} odd periods for n <= #{limit}"
