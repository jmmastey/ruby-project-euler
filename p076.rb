
def parts(num,cache)
  return cache[num] if cache.include? num

  sum = 0
  pairs = []
  1.upto(num-1) do |i|
    pair = [num-i,i].sort
    if pairs.include? pair
      sum += 1
      p "sum is #{sum}"
      next
    end

    pairs << pair
    sum += parts((num-1-i),cache)
    p "sum is now #{sum}"
  end

  (cache[num] = sum)
end


cache = { 1 => 1, 0 => 1 }
2.upto 5 do |i|
  p = parts(i, cache)
  puts "#{i} has #{p}"
end
