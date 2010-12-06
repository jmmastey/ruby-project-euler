
def concatenated_product n
  pr = ""
  i = 0

  while 9 > pr.length
    pr += (n * (i+=1)).to_s
  end

  return nil if 9 != pr.length
  return pr
end

class String
  def is_pandigital?
    self.split(//).sort.join('') == "123456789"
  end
end

# I don't know why this is the theoretical ceiling, but it yields a correct answer
ceil = 10000
max = 0
1.upto ceil do |i|
  cpr = concatenated_product i
  next unless cpr &&  cpr.is_pandigital?
  puts cpr
  max = [max,cpr.to_i].max
end

puts "\nmax is #{max}"
