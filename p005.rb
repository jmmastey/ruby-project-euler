class Fixnum
  def prime?
    ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/
  end
end

k = 20

operands = []

2.upto k do |i|
  next unless i.prime?

  max = 0
  1.upto k do |j|
    next if i**j > k
    max = i**j
  end

  operands << max
end

puts operands.inject(1) { |sum,i| sum *= i }
