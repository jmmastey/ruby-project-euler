require 'mathn'
require 'tools'

def is_permutation?(n,phi)
  n.to_s.split(//).sort == phi.to_s.split(//).sort
end

min = 999
phi = Sieve.phi_to_10m
phi.each do |n,phi|
  next unless n > 1_000_000
  next unless is_permutation?(n,phi)
  ratio = n/phi

  next unless ratio < min && 1 != n
  min = ratio
  p "#{n}:#{phi} #{n/phi}"
end
