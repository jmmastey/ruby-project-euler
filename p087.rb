require 'tools'

nm = {}
max = 50_000_000
primes = Sieve.quick_primes_to(max.root(2)+1)

square = []
0.upto(primes.length-1) do |i|
  sq = primes[i]**2
  break if sq > max
  square << sq
end

cube = []
0.upto(primes.length-1) do |i|
  cb = primes[i]**3
  break if cb > max
  cube << cb
end

fourth = []
0.upto(primes.length-1) do |i|
  fth = primes[i]**4
  break if fth > max
  fourth << fth
end

puts "s:#{square.length} c:#{cube.length} f:#{fourth.length}"

square.each do |s|
  cube.each do |c|
    break if s+c >= max
    fourth.each do |f|
      sum = s+c+f
      break if sum > max
      nm[sum] = nil
    end
  end
end

p nm.length
