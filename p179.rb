lim = 10_000_000
nms = Array.new(lim+1, 1)

# 1 was initialized above
2.upto lim do |i|
  j = i
  while j < lim
    nms[j] += 1
    j += i
  end
end

sum = 0
1.upto lim do |i|
  sum += 1 if nms[i] == nms[i+1]
end

p sum
