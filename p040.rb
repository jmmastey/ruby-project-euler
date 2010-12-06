str = ""
i = 1
while str.length < 1000000
  str += i.to_s
  i += 1
end

d = []
d << str[0,1]
d << str[9,1]
d << str[99,1]
d << str[999,1]
d << str[9999,1]
d << str[99999,1]
d << str[999999,1]

puts "#{str.length} digits generated in #{i}"
puts d.join " "
puts d.inject(1) { |sum,k| sum *= k.to_i }
