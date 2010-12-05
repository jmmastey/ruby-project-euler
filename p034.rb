class Fixnum

  def fact
    sum = 1
    self.downto(1) { |k| sum *= k }
    sum
  end

end

lim = 1000000
ans = []
3.upto lim do |i|
  sum = 0
  i.to_s.split(//).each do |d|
    sum += d.to_i.fact
    next if sum > i
  end

  ans << i if i == sum
end

puts ans
puts ""
puts ans.inject(0) { |sum,i| sum += i }
