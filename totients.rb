require 'tools'

lim = 10_000_000
@phi = Sieve.clever_phi_to lim

@phi.sort.each do |n,phi|
  puts "#{n}:#{phi}"
end
