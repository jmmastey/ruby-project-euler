class Fixnum
  def fact
    (1..self.to_i).inject(1){|sum,i| sum *= i}
  end
end

gridsize = 20
p (gridsize*2).fact/(gridsize.fact**2)
