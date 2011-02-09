require 'tools'

lim = 100_000_000
primes = Sieve.primes_to(lim/2)
lessthan = []
t = 0

primes.each do |pr|
  lessthan << pr

  slim = lim/pr
  lessthan.each do |lt|
    break if lt > slim
    t += 1
  end
end

p t
