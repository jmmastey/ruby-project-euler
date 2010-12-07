require 'tools'

def prime_and_square(target, primes)
  sqrt = target**0.5
  1.upto sqrt do |k|
    return true if primes.include? target-(2*k**2)
  end

  return false
end

max = 10000
primes = Sieve.get_primes_to max

(3..max).step(2) do |k|
  next if primes.include? k
  next if prime_and_square(k, primes)
  puts k
  exit
end

puts "Didn't find anything."
