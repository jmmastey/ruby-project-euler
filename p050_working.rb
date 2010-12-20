require 'tools'

# finds the right answer in about 5 seconds, but exhaustively searches
# the rest of the space for another minute or so before coming to a stop.
#
# this should actually be sped up much further by observing the maximum
# chain length yeiling N < 1M (which is 546). another minor optimization
# would be to use a smarter way to get the sum

lim = 1_000_000
@primes = Sieve.get_primes_to(lim/2)
@lookup = Sieve.get_primes_to(lim).tohashkeys
tlen = @primes.length
max = 0


0.upto @primes.length-1 do |i|
  exit if tlen-i < max
  exit if @primes[i]*max > lim

  subprime = @primes[i..-1]
  sum = subprime.sum
  (subprime.length-1).downto 0 do |j|
    sum -= subprime[j]
    len = j-i

    break if len < max
    next if sum > lim
    next unless sum.prime?(@lookup)

    puts "#{sum} is the sum of #{len} primes (from #{subprime[0]} to #{subprime[j-1]})"
    max = len
    break
  end

end
