
require 'tools'

primes = Sieve.primes_to_1m
keys = primes.tohashkeys

max = 500
mlen = primes.length
mlen.downto max do |slen|
  break if slen <= max

  # 0..max, 1..max, 2..max
  sum = primes[(mlen-slen)..(mlen-1)].sum
  len = slen

  # only iterate as far as makes sense
  found = false
  (slen-1).downto max+1 do |i|
    break if found

    slen -= 1
    sum -= primes[i]

    next if sum > 1e6
    break if sum < 1e5
    if sum.prime?(keys)
      puts "#{sum} (#{slen})"
      max = [max,slen].max
      found = true
      break
    end
  end
end
