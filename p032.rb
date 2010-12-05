
def is_pandigital? arr
  arr.to_s.split(//).sort.join == "123456789"
end

def find_multiplicands(product, stack)
  1.upto(product**0.5) do |m|
    next unless 0 == product%m
    next unless is_pandigital? [product, m, (product/m)]

    stack << [product, m, (product/m)]
    return
  end
end


pandigitals = []
1.upto(10000) { |pr| find_multiplicands(pr, pandigitals) }

sum = 0
pandigitals.each { |p| puts p.join ' '; sum += p[0] }
puts "sum is #{sum}"
