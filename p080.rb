require 'tools'

sum = 0
2.upto 100 do |n|
  next if n**0.5 % 1 == 0
  sum += n.root_digits(99).sub(".","").split(//).inject(0) { |sum,s| sum + s.to_i }
end

p sum
