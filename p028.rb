sum = 1
i = slen = 1
slimit = 1001

while slen < slimit
  4.times do
    i += (slen+1)
    sum += i
  end

  slen += 2
end

puts "sum for square of size #{slimit} is #{sum} (last number was #{i})"
