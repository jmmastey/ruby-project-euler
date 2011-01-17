require 'tools'

# apparently this is known as the Farey series

lim = 1e6
phi = Sieve.phi_to(lim)
phi.delete 1
phi.delete 0

p phi.inject(0) { |sum,p| sum += p[1] }
