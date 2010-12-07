require 'tools'

targetlen = 4
i = 1
lim = 1000000
primes = Sieve.get_primes_to lim
ph = primes.tohashkeys
puts "Getting started now"

while true
  exit if i > lim
  puts i if 0 == i%1000

  pfs = []
  valid = true
  targetlen.downto 1 do |o|
    ti = i+(o-1)

    if primes.include? ti
      pf = []
    else
      pf = (i+(o-1)).prime_factors(primes).to_a
    end

    if pf.length != targetlen
      valid = false
      i += o
      break
    end

    pfs << pf
  end

  next unless valid

  puts "#{i} looks pretty good"
  cat = pfs.inject([]) { |coll,j| coll += j }
  if cat.uniq != cat
    i += 1
    next
  end

  p i
  exit
end
