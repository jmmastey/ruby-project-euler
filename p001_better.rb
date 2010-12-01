#!/usr/bin/ruby

def sum_for_modulo(max, modulo)
  # there are X occurrences, which on average are worth N (first+last/2).
  # so, the sum of the X occurrences is X*N
  occ = (max-1)/modulo
  last = occ*modulo
  avg = (last+modulo)/2.0
  puts "sum for modulo #{modulo} is #{avg*occ} (avg is #{avg}, occ is #{occ}, last is #{last})"
  avg*occ
end

def sum_under_int max
  (sum_for_modulo(max, 3)+sum_for_modulo(max, 5)-sum_for_modulo(max, 15)).to_i
end

max = (!ARGV.empty? && ARGV[0].to_i) || 1000

puts sum_under_int max
