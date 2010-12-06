require 'tools'

def is_odd? s
  return false if 0 != s[1,3].to_i % 2
  return false if 0 != s[2,3].to_i % 3
  return false if 0 != s[3,3].to_i % 5
  return false if 0 != s[4,3].to_i % 7
  return false if 0 != s[5,3].to_i % 11
  return false if 0 != s[6,3].to_i % 13
  return false if 0 != s[7,3].to_i % 17
  return true
end

arr = (0..9).to_a
sum = 0
p = Permuter.new(arr)
begin
  while true
    p.permute!
    next unless is_odd? p.to_s

    sum += p.to_i
    puts p
  end
rescue StandardError => bang
  puts bang
end

puts "Total is: #{sum}"
