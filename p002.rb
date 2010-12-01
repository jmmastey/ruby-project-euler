#!/usr/bin/ruby

def sum_even_fibbs max
  sum, a, b = 0, 1, 1
  while true
    a, b = b, (a+b)

    break if b >= max

    print " #{b}"
    sum += b if (b%2 == 0)
  end

  puts "\n"
  sum
end


max = (!ARGV.empty? && ARGV[0].to_i) || 4000000
puts sum_even_fibbs max
