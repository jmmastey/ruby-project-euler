
div_limit = 500
divisors = triangle = nat = 0

while divisors < div_limit
  divisors = 0
  triangle += (nat +=1)

  1.upto(triangle**0.5) do |divisor|
    divisors += 2 if (0 == triangle % divisor)
  end

  #puts "#{triangle}: #{divisors}" if divisors > 300
end

puts triangle
