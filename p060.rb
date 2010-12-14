require 'tools'

lim  = 1000
primes = Sieve.get_primes_to lim
lookup = primes.tohashkeys
max = (primes.max.to_s * 2).to_i
divlist = (2..max)

sols = {}
primes.each do |pr1|
  friends = [pr1]
  pr1s = pr1.to_s

  primes.each do |pr2|
    ab = (pr1s + pr2.to_s).to_i
    ba = (pr2.to_s+pr1s).to_i
    friend = true

    unless lookup.include?(ab) || ab.prime_by_trial?(divlist)
      friend = false
    end
    unless lookup.include?(ba) || ba.prime_by_trial?(divlist)
      friend = false
    end

    next unless friend
    friends << pr2
    lookup[ab] = nil
    lookup[ba] = nil
  end

  sols[pr1] = friends.sort if friends.length >= 4
end

p sols
