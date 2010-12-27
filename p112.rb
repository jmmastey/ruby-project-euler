class Fixnum
  def increasing?
    s = self.to_s
    s == s.split(//).sort.join('')
  end

  def decreasing?
    s = self.to_s
    s == s.split(//).sort.reverse.join('')
  end

  def bouncy?
    !self.increasing? && !self.decreasing?
  end

end

i = 0
unbouncy = 0

while true
  i += 1
  unbouncy += 1 unless i.bouncy?
  puts "#{unbouncy} / #{i} #{unbouncy*1.0/i}" if i % 25000 == 0

  next unless unbouncy*100 == i
  break
end

p i
