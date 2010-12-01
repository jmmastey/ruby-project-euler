class Fixnum
  def prime?
    ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/
  end
end

puts ((1..2000).select &:prime?).inject(0) { |sum,i| sum += i }
