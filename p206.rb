tgt = /1.2.3.4.5.6.7.8.9.0/
low =  (1020304050607080900**0.5).to_i
high = (1929394959697989990**0.5).to_i

i = high-(high%10)
while i > low
  i -= 10
  p i if i % 1000000 == 0

  sq = i**2
  next unless sq.is_a? Bignum
  next unless tgt.match sq.to_s
  puts "#{i} #{sq}"
  exit
end
