require 'tools'

def friendly?(str1, str2, lookup, pmax)
  s1 = (str1 + str2).to_i
  s2 = (str2 + str1).to_i

  return false if (s1 < pmax && !lookup.include?(s1))
  return false if (s2 < pmax && !lookup.include?(s2))
  return false unless s1.prime?
  return false unless s2.prime?

  return true
end

lim = 10000
primes = Sieve.get_primes_to(lim)
lookup = primes.tohashkeys
pmax = primes.max

primes.delete 2
plen = primes.length-1

# unroll the fucker
0.upto plen do |i1|
  p1 = primes[i1]
  p1s = p1.to_s

  puts "start on #{p1s}"
  i1.upto plen do |i2|
    p2 = primes[i2]
    p2s = p2.to_s
    next unless friendly?(p2s, p1s, lookup, pmax)

    i2.upto plen do |i3|
      p3 = primes[i3]
      p3s = p3.to_s
      next unless friendly?(p3s, p1s, lookup, pmax)
      next unless friendly?(p3s, p2s, lookup, pmax)

      i3.upto plen do |i4|
        p4 = primes[i4]
        p4s = p4.to_s
        next unless friendly?(p4s, p1s, lookup, pmax)
        next unless friendly?(p4s, p2s, lookup, pmax)
        next unless friendly?(p4s, p3s, lookup, pmax)

        i4.upto plen do |i5|
          p5 = primes[i5]
          p5s = p5.to_s
          next unless friendly?(p5s, p1s, lookup, pmax)
          next unless friendly?(p5s, p2s, lookup, pmax)
          next unless friendly?(p5s, p3s, lookup, pmax)
          next unless friendly?(p5s, p4s, lookup, pmax)

          answer = [p1,p2,p3,p4,p5]
          p answer
          puts answer.inject(0) { |sum,i| sum + i }
        end
      end
    end
  end
end
