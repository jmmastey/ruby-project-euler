
pentags = []
1.upto 10000 do |i|
  pentags << i*((3*i)-1)/2
end

min = 9999999
1.upto(pentags.length-1) do |j|
  (j-1).downto 1 do |k|
    curr = pentags[j]
    down = pentags[(j-k)]

    next unless pentags.include?(curr+down)
    next unless pentags.include?(curr-down)
    diff = j-k

    puts "#{j} and #{k} work. (diff is #{diff})"
    min = [min,diff].min
  end
end

puts "min difference was #{min}"
