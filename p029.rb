terms = []

2.upto 100 do |a|
  2.upto 100 do |b|
    terms << a**b
  end
end

puts terms.uniq.length
