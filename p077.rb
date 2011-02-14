require 'tools'

primes = Sieve.primes_to_1k
lim = 5000

tgt = 1
while true
  ways = [1] + [0]*tgt
  primes.each do |i|
    (i).upto(tgt) { |j| ways[j] += ways[j-i] }
  end
  break if ways[tgt] > lim
  tgt += 1
end

p tgt
