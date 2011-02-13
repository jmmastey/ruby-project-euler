require 'tools'

levels = 51
aggregate = []
row = [1, 1]
2.upto levels-1 do |level|
  new_row = [1]
  0.upto(row.length-2) do |pos|
    new_row << row[pos]+row[pos+1]
  end

  new_row << 1
  row = new_row
  aggregate += row
end

# all unique numbers from the first n levels of pascal's triangle
uniques = aggregate.uniq.sort

# wikipedia sez: http://en.wikipedia.org/wiki/Squarefree
# The positive integer n is square-free if and only if in the prime
# factorization of n, no prime number occurs more than once.

# while it's possible that there could be a repeated prime factor
# of substantial size, I guessed that repeated factors would tend
# to be very small numbers, and it turns out I was right.
primes = Sieve.primes_to_1k

squarefrees = []
uniques.each do |n|
  next if n == 1
  repeated_factors = n.prime_factors(primes).select { |k,v| v > 1 }
  next unless repeated_factors.length == 0

  squarefrees << n
end

p squarefrees.sum+1
