k = 100

sum_of_sq = (1..k).inject(0) { |sum,i| sum += i**2 }
sq_of_sum = (k*(k+1)/2)**2

puts "sum of squares: #{sum_of_sq}"
puts "square of sums: #{sq_of_sum}"
puts "diff of the two: #{sq_of_sum - sum_of_sq}"
