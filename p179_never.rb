require 'tools'

@lim = 10_000_000
@primes = Sieve.quick_primes_to_15m
@lookup = Sieve.quick_primes_to_15m(true)
@nfactors = {}
def nfactors i
  if !@nfactors.include? i
    @nfactors[i] = i.prime_factors(@primes).values.inject(1) { |d,a| d * (a+1) }
  end
  @nfactors[i]
end

puts "starting"

last = 0
sum = 1 # i = 2
@lim.downto 3 do |i|
  # we need a nonprimality match to continue
  next if @lookup.include?(i) || @lookup.include?(i+1)
  p i
  next unless nfactors(i) == nfactors(i+1)
  sum += 1
end

p sum
