def digital_sum n
  n.to_s.split(//).inject(0) { |sum,s| sum + s.to_i }
end


lim = 20
i = 10
ct = 1

while ct <= lim
  i += 1

  ds = digital_sum i
  next unless i % ds == 0

  1.upto 10 do |pow|
    next unless ds**pow == i
    p [ct, ds, pow, i]
    ct += 1
  end
end
