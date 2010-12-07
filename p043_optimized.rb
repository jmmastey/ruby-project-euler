require 'tools'

# this needs real refactorization. try finding acceptable numbers as an
# approach instead. For instance, we already have a good guess for [5,3] (see below)
# so we should be able to manually peg digits this way

def is_odd? s
  return false unless ["0","2","4","6","8"].include? s[3,1]
  return false if 0 != s[2,3].to_i % 3
  return false unless "5" == s[5,1]
  return false if 0 != s[4,3].to_i % 7
  return false unless ["506","517","528","539","561","572","583","594"].include? s[5,3]
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
