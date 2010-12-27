lim = 1000
max = 0
2.upto lim do |d|
  next if d**0.5%1 == 0

  y = 1
  while true
    x = (d*y**2+1)**0.5
    break if 0 == x%1
    y += 1
  end

  p [x.to_i,d,y.to_i]
  if x > max[1]
    max = [d,x.to_i,y.to_i]
  end
end

p max
