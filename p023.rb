class Fixnum
  def sum_of_divisors
    n = self.to_i
    divisors = [1]
    2.upto(n**0.5) do |i|
      if 0 == n%i
        divisors << i
        divisors << n/i unless n/i == i
      end
    end

    divisors.inject(0){|sum,i| sum += i}
  end

  def perfect?
    sum_of_divisors == self.to_i
  end

  def abundant?
    sum_of_divisors > self.to_i
  end

  def deficient?
    sum_of_divisors < self.to_i
  end
end

#max = 28123
max = 20162
abnums = (1..max).select { |i| i.abundant? }

absums = []
abnums.each do |i|
  abnums.each do |j|
    break if i+j > max
    absums << i+j
  end
end

sol = (0..max).to_a - absums
p sol.inject(0) { |sum,i| sum+i }
