max = (9**5)*6
hits = []
2.upto max do |i|
  hits << i if i == (i.to_s.split //).inject(0) { |sum,d| sum += d.to_i**5 }
end

puts hits
puts hits.inject(0) { |sum,i| sum += i }
