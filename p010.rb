require 'tools'

sum = 0
File.open("primes_to_15m.txt") do |file|
  while line = file.gets
    line.chomp.split.each do |s|
      i = s.to_i
      break if i > 2_000_000
      sum += i
    end
  end
end

p sum
