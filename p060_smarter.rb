require 'tools'

# So this code, basically in its entirety, is a monster.
# the problem lies in finding friendly primes in a reasonable
# fashion. or, more particularly, checking primality of huge
# sets of numbers.
#
# To accomplish this, I use a primelist for all n < 100M. For larger
# primes, we would still have issues, though. I need to implement AKS
# to handle this.

def friendly?(str1, str2)
  s1 = (str1 + str2).to_i
  s2 = (str2 + str1).to_i

  return (@lookup.include?(s1) if s1 < @lmax &&
          @lookup.include?(s2) if s2 < @lmax)
end

# find all numbers friendly to another given number
def friendly_to(str1, arr)
  arr.select { |elem| friendly?(str1, elem.to_s) }
end

lim = 10000
primes = Sieve.primes_to(lim)
@lookup = Sieve.primes_to_100m true
@lmax = @lookup.keys.max
@misclookup = {}

# unroll the fucker
0.upto(primes.length-1) do |i|
  p1 = primes[i]
  p1s = p1.to_s
  puts "start on #{p1s}"
  flist1 = friendly_to(p1s, primes)

  flist1.each do |p2|
    p2s = p2.to_s
    flist2 = friendly_to(p2s, flist1)
    next unless flist2.length >= 3

    flist2.each do |p3|
      p3s = p3.to_s
      flist3 = friendly_to(p3s, flist2)
      next unless flist3.length >= 2

      flist3.each do |p4|
        p4s = p4.to_s
        flist4 = friendly_to(p4s, flist3)
        next unless flist4.length >= 1

        flist4.each do |p5|
          answer = [p1,p2,p3,p4,p5]
          p answer
          puts answer.inject(0) { |sum,i| sum + i }
        end
        exit
      end
    end
  end
end
