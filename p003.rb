#!/usr/bin/ruby


def largest_prime_factor max
  lgst = 0
  head= Math.sqrt(max)
  (1..head).step(2) do |i|
    #find factors
    next unless max%i == 0

    # test primality
    puts "found candidate #{i.to_i}\n"
    lgst = i if is_prime? i
  end

  lgst.to_i
end

def is_prime? num
  pfactor = Math.sqrt(num).to_i

  while pfactor > 1
    return false if (0 == (num.to_f/pfactor.to_f)%1)
    pfactor -= 1
  end

  return true
end

max = (!ARGV.empty? && ARGV[0].to_i) || 600851475143
puts largest_prime_factor max
