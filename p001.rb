#!/usr/bin/ruby

def sum_under_int max
  sum = 0
  (0...max).each do |nm|
    sum += nm if 0 == nm%3 || 0 == nm%5
  end
  sum
end

max = (!ARGV.empty? && ARGV[0].to_i) || 1000

puts sum_under_int max
