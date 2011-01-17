require 'mathn'
require 'tools'

lim = 1_000_000
factors = {}
max = 0
maxnover = nil
@phi = Sieve.phi_to lim
@phi.delete 0

@phi.each do |n,phi|
  nover = n/phi
  puts "#{phi} for #{n}" if 0 == n % 10_000
  next unless max < nover

  max = nover
  maxnover = [n, nover.to_f]
  puts ">> #{nover} for #{n}"
end

p maxnover
