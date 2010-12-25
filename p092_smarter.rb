require 'tools'

def sd n
  n.to_s.split(//).inject(0) { |sum,s| sum + (s.to_i**2) }
end

lookup = (1..600).to_a.tohashkeys
lookup.each do |k,v|
  klocal = k
  while klocal != 89 and klocal != 1
    klocal = sd klocal
  end

  lookup[k] = (klocal == 89)? 1 : 0
end
p "Precomputed for <= 600"

sum = 0
lim = 1e7
1.upto lim do |i|
  puts "#{i}: #{sum}" if 0 == i % 10000

  i = sd i
  raise "Found missing key #{i}" unless lookup.include? i
  sum += lookup[i]
end

p sum
