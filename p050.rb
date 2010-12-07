
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

primes = Sieve.get_primes_to 1000000
max = 0
maxkey = []
(primes.length-1).downto 0 do |k|
  pr = primes[k]
  0.upto k do |j|
    ct = prime_sum(pr, j, primes)
    if ct > max
      max = ct
      maxkey = { :prime => pr, :start => primes[j], :length => ct}
    end
  end
end

p maxkey
