require 'tools'

def prime_sum(target, st, primes)
  n = st
  while target > 0
    target -= primes[n]
    n += 1
  end

  return 0 if target != 0
  return (n-st)
end

max = 1
cap = 1000000
maxsol = {}
primes = Sieve.primes_to_10k
0.upto(primes.length-1) do |i|
  maxlen = primes.length-i
  maxlen.downto max+1 do |j|
    next if primes[i]*j > cap

    sum = primes[i,j].inject(0) { |sum,k| sum += k }
    next unless sum < cap
    next unless sum.prime?(primes)

    max = j
    maxsol = { :prime => sum, :len => j }
    p maxsol
    break
  end
end

puts "MAX:"
p maxsol
