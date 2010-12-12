
class Bignum
  def sumdigits
    self.to_s.split(//).inject(0) { |sum,s| sum + s.to_i }
  end
end

class Fixnum
  def sumdigits
    self.to_s.split(//).inject(0) { |sum,s| sum + s.to_i }
  end
end


limit = 100
max = 0


1.upto limit do |a|
  1.upto limit do |b|
    max = [max, (a**b).sumdigits].max
  end
end

p max
