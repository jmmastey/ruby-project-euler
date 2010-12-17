require 'tools'

lim = 1000000
factors = {}
max = 0
maxnover = nil

lim.downto 2 do |n|
  factors[n] = n.factors - [1] unless factors.include? n
  coprime = []
  1.upto n do |k|
    factors[k] = k.factors - [1] unless factors.include? k

    coprime << k if (factors[n] & factors[k]).length == 0
  end

  nover = n * 1.0 / coprime.length
  if max < nover
    max = nover
    maxnover = [n, nover, coprime]
    puts "#{nover} for #{n}"
  end

  p n
end

p maxnover
