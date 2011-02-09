require 'tools'

primes = Sieve.primes_to_1000
p primes
res = {}
lim = 40_000_000
lim = 10

1.upto lim do |i|
  sum = 0
  primes.each do |pr|
    break if pr > i/2
    j = i-pr
    p j
    sum += res[j] + (primes.include?(j) ? 1 : 0)
    p " #{sum}"
  end
  res[i] = sum
  p res
end
