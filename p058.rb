require 'tools'

@lookup = Sieve.primes_to_1m
primes = 3
total = 5

sl = 3
ctr = 9

while true
  sl += 2
  mv = sl - 1

  primes += 1 if (ctr+mv).prime_by_trial?(@lookup)
  primes += 1 if (ctr+2*mv).prime_by_trial?(@lookup)
  primes += 1 if (ctr+3*mv).prime_by_trial?(@lookup)

  total += 4
  ctr += 4*mv

  # debug
  #puts "#{ctr} #{primes} #{total} #{sl}"
  next unless primes*10 < total

  p sl
  exit
end
