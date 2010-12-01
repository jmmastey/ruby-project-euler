factors = (1..200).to_a
final_factors = []
current_factor = 2

while factors.length > 0
  factor_is_valid = false
  next_factors = []

  factors.each do |f|
    next if 1 == f

    if 0 != (f%current_factor)
      next_factors << f
      next
    end

    factor_is_valid = true
    result = f/current_factor

    next if result == 1
    next_factors << result
  end

  if factor_is_valid
    puts "#{current_factor} is a factor #{next_factors}"
    final_factors << current_factor
  else
    current_factor += 1
  end

  factors = next_factors
end

lcm = final_factors.inject(1) { |sum,i| sum *= i }
puts "final LCM is #{lcm}"
