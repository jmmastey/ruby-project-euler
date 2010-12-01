#!/usr/bin/ruby

# F(n) = F(n-1) + F(n-2)
# since evens repeat every third digit, we can also prove:
# E(n) = 4*E(n-1) + E(n-2)
# so, store n-2 as well and iterate only the evens
def sum_even_fibbs max
  sum, a, b, c = 44, 2, 8, 34
  while true
    a, b, c = b, c, (4*c+b)

    break if c >= max

    print " #{c}"
    sum += c
  end

  puts "\n"
  sum
end

max = (!ARGV.empty? && ARGV[0].to_i) || 4000000
puts sum_even_fibbs max
