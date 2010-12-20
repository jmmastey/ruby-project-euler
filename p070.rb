require 'tools'

max = 10e2
pr = Sieve.get_primes_to(max/2)
1.upto max do |i|
  p i.phi(pr)
end
