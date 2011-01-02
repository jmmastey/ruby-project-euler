require 'tools'

# I had a lot more clever math here, and it ran in 30 seconds, but
# I couldn't get the right answer out of it. So forget it. This runs
# in 1m7s, which is good enough.

lim = 100_000
tgt = 10_000
@idx = []
primes = Sieve.get_primes_to lim

1.upto lim do |i|
  factors = i.prime_factors(primes).keys
  key = factors.product
  @idx << [key,i]
end

p @idx.sort[tgt-1][1]
