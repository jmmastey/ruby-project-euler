require 'tools'

@primes = Sieve.primes_to_1m
n = 600_851_475_143
puts n.prime_factors(@primes).keys.max
