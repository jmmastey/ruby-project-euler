require 'tools'

def remainder n
  mod = @primes[n-1]**2
  (((@primes[n-1]-1)**n % mod) + (@primes[n-1]+1)**n) % mod
end

lim = 10**10
@primes = Sieve.primes_to_1m
15900.upto(@primes.length) do |n|
  p n
  next unless remainder(n) > lim
  p [n, remainder(n)]
  exit
end
