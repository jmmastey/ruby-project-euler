def mods_work? num
  [11,12,13,14,15,16,17,18,19,20].each do |i|
    return false if (num%i != 0)
  end

  return true
end

def multsum arr
  sum = 1
  arr.each { |i| sum *= i }
  sum
end

shitty_answer = multsum((11..20).to_a)
puts "looking for something better than #{shitty_answer}"

nm = 0
step = 2520
while nm <= shitty_answer
  nm += step

  puts "trying #{nm}"
  if mods_work? nm
    puts nm
    exit
  end
end
