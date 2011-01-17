require 'tools'

primes = Sieve.primes_to 31500

max = 0
# originally we tested from 9 digits, but because
# sum(1..9) % 3 == 0, all 9-digit pandigital numbers are nonprime.
# same thing works for 8 digits.
7.downto 2 do |len|
  seq = (1..len).to_a
  p = Permuter.new(seq)
  begin
    while true
      p.permute!
      if p.to_i.prime_by_trial?(primes)
        max = p.to_i
      end
    end
  rescue StandardError => bang
    # do nothing
  end

  if max > 0
    p max
    exit
  end
end

puts "No primes found?"
