require 'tools'

# 1: the replaced digit should be in [0..3] to start the family
# 2: replace in sets of three, or at least three of the resulting numbers will be divisible by three

target = 7

def check_family(str, target)
  return unless str.scan(/[0123]/).length > 0

  ["0","1","2","3"].each do |k|
    next unless str.scan(k).length > 0

    ans = []
    ["0","1","2","3","4","5","6","7","8","9"].each do |r|
      nstring = str.gsub(k,r).to_i
      ans << nstring if nstring.prime?
    end

    if ans.length >= target
      print str+" "
      p ans
      exit
    end
  end
end

primes = Sieve.get_primes_to(100000)
primes.each do |pr|
  check_family(pr.to_s, target)
end
