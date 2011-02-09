
class Fixnum
  def square?
    (self**0.5)%1 == 0
  end
end

3.upto 100_000 do |x|
  p x if x % 100 == 0
  2.upto x-1 do |y|
    1.upto y-1 do |z|
      next unless (x+y).square?
      next unless (x-y).square?
      next unless (x+z).square?
      next unless (x-z).square?
      next unless (y+z).square?
      next unless (y-z).square?
      p [x,y,z].sum
      exit
    end
  end
end
