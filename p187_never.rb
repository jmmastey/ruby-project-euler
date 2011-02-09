require 'tools'

#lim = 10_000_000
lim = 300_0
pr = Sieve.primes_to(lim, true)
ans = {}
t = 0
sqrt = lim**0.5

2.upto lim do |i|
  next if ans.include? i

  fct = i.prime_factors(pr)
  s = fct.inject(0){|t,v| t + v[1] }

  next unless s == 2

  t += 1
  1.upto(lim/i) do |m|
    next if m == i
    ans[m*i] = nil
  end

end

p t
