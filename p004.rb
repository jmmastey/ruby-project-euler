max = 0
999.downto 100 do |i|
  i.downto 100 do |j|
    sum = i*j
    break if sum < max

    max = [max,sum].max if sum.to_s == sum.to_s.reverse
  end
end

puts max
