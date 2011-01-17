require 'tools'

def friendly?(str1, str2)
  (str1 + str2).to_i.prime? and (str2 + str1).to_i.prime?
end

lim  = 1000
primes = Sieve.primes_to lim

sols = {}
primes.each do |pr|
  prs = pr.to_s
  next if sols.include? prs

  0.upto primes.length do |i|
    cpr = primes[i].to_s

    if friendly?(cpr, prs)
      sols[prs] = [cpr]
      sols[cpr] = [prs]
      break
    end
  end
end

# now we have a list of candidate "friendly" primes, for 
# which we can check all other friendly primes for matches.

sols.delete ""

# abandon all hope
solkeys = sols.keys
p solkeys.length
p primes.length
exit

sols.each do |prs,keys|
  solkeys.each do |cpr|
    next if cpr == keys[0]

    if friendly?(cpr, prs)
      keys << cpr
    end
  end

  keys << prs
  sols.delete prs if keys.length < 5
end

sols.each do |whocares,set|
  puts "trying #{set.join ','}"

  set = set.sort
  combos = set.combinations_for 5
  0.upto combos.length-1 do |idx|
    candidate = combos[idx]
    next if candidate.nil?

    valid = true
    candidate.combinations_for(2).each do |pair|
      next if friendly?(pair[0], pair[1])

      # invalidate other combos that contain this pair
      idx.upto combos.length-1 do |future_idx|
        next if combos[future_idx].nil?

        intersect = combos[future_idx] & pair
        next unless intersect && 2 == intersect.length
        combos[future_idx] = nil
      end

      valid = false
      break
    end

    next unless valid

    # found it
    p candidate
    exit
  end
end
