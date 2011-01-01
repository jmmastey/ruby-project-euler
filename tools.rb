
class Fixnum
  @@factorials = {}

  def factorial
    if !@@factorials.include? self
      total = 1
      return total unless self > 1
      self.downto 1 do |r|
        total *= r
      end
      @@factorials[self] = total
    end

    return @@factorials[self]
  end

  def prime?(primes = nil)
    return self.prime_by_trial?(primes = nil) if self > 10000000
    return ('1' * self.to_i) !~ /^1?$|^(11+?)\1+$/ if primes.nil?
    return primes.include? self
  end

  def prime_by_trial?(primes = nil)
    return false if 0 != self.clever_primecheck

    sqrt    = self**0.5
    primes  = Sieve.get_primes_to sqrt unless primes
    primes.each do |t|
      return true if t > sqrt
      return false if 0 == self%t
    end

    return true
  end

  def clever_primecheck
    digits = self.to_s.split //

    # 2s - any even last digit
    return 2 if ["0","2","4","6","8"].include? digits.last
    # 3s - sum of digits divisible by 3
    return 3 if 0 == (digits.inject(0) { |sum,p| sum += p.to_i }) % 3
    # 4s - last two digits divisible by 4
    return 4 if (digits.length >= 2 && 0 == digits[-2,2].join("").to_i % 4)
    # 5s - last digit is either 0 or 5
    return 5 if ["0","5"].include? digits.last
    # 6s - already includes divisibility by 2 and 3, so skip it
    # 8s - number formed by last 3 digits is divisible by 8
    return 8 if (digits.length >= 3 && 0 == digits[-3,3].join("").to_i % 8)
    # 9s - sum of digits is divisible by 9
    return 9 if 0 == (digits.inject(0) { |sum,p| sum += p.to_i }) % 9

    # we win the silly checks
    return 0
  end

  def factors
    f = []
    sqrt = (self**0.5)+1
    1.upto sqrt do |k|
      if 0 == self%k
        f << k
        f << self/k if self/k != k
      end
    end

    f
  end

  @@prime_factors = {}

  def prime_factors(primes = nil)
    return {self => 1} if self.prime?
    return @@prime_factors[self] if @@prime_factors.include? self

    primes = Sieve.get_primes_to self**0.5 unless primes
    target = self
    facts = {}
    k = 0
    while true
      break if target == 1
      break if k >= primes.length

      pr = primes[k]
      if pr > target
        k += 1
        next
      end

      if 0 == target%pr
        facts[pr] ||= 0
        facts[pr] += 1
        target = target/pr
        next
      end

      k += 1
    end

    (@@prime_factors[self] = facts)
  end

  # find the number of integers < n that are 
  # coprime to n
  def phi(primes = nil)
    return self - 1 if self.prime?
    return 1 if self == 1

    primes = Sieve.get_primes_to(self**0.5) unless primes
    pf = self.prime_factors(primes)
    return pf.inject(1) do |prod, pair|
      prod *= (pair[0]-1)*pair[0]**(pair[1]-1)
    end
  end

  def root(pow)
    self**(1.0/pow)
  end

  def gcd(b)
    MathUtils.gcd(self,b)
  end

  def partitions
    _partitions(1,self)
  end

  def parts
    return 0 if self == 0
    return 1 if self == 1
    sum = 0
    1.upto self do |k|
      sign = -1**(k+1)
      d1 = (self - 0.5*k*(3*k-1)).to_i.parts
      d2 = (self - 0.5*k*(3*k+1)).to_i.parts
      sum += sign*d1*d2
    end
  end

  def _partitions(k,n)
    return 0 if k > n
    return 1 if k == n
    return _partitions(k+1,n) + _partitions(k, n-k)
  end
  protected :_partitions

  # square root to n digits
  def root_digits(lim)
    def pairs
      s = self.to_s

      if s.length.odd?
        lead = s[0]
        s = s[1..-1]
      end

      pairs = s.scan(/../)
      pairs = [lead] + pairs if lead

      pairs
    end

    def get_pair(pairs,n)
      return "00" if n >= pairs.length
      pairs[n]
    end

    def solve_digs(tgt, base)
      1.upto 9 do |n|
        return [n-1, "#{base}#{n-1}".to_i*(n-1)] if "#{base}#{n}".to_i * n > tgt
      end
      return [9,"#{base}9".to_i*9]
    end

    prs = pairs

    ndigs = 0
    idx = 0
    res = ""
    wk = get_pair(prs,idx).to_i

    dig = (wk**0.5).to_i
    res += dig.to_s
    carry = (wk.to_i - dig**2).to_s

    while ndigs < lim
      idx += 1
      if idx == prs.length
        res += "."
        ndigs = 0
      end

      wk = (carry + get_pair(prs,idx)).to_i
      base = res.sub(".", "").to_i * 2

      r = solve_digs(wk, base)
      dig,sub = r[0],r[1]

      res += dig.to_s
      carry = (wk - sub).to_s
      ndigs += 1
    end

    res
  end
end

class Array

  # cast each member to an integer
  def to_is
    self.each_index { |i| self[i] = self[i].to_i }
  end

  # is this sorted in reverse?
  def rsorted?
    return true if 1 == self.length
    return self[0] >= self[1] if 2 == self.length
    self == self.sort.reverse
  end

  # swap two values in the array
  def swap!(val1, val2)
    i1 = self.index val1
    i2 = self.index val2

    return if (i1.nil? or i2.nil?)
    self[i1], self[i2] = self[i2], self[i1]
  end

  # get all values as hashkeys (for O(1) lookup)
  def tohashkeys
    h = {}
    self.each do |k|
      h[k] = nil
    end
    h
  end

  # get sum of all elems
  def sum
    self.inject(0) { |sum,i| sum += i; sum }
  end

  # get product of all elems
  def product
    self.inject(1) { |prod,i| prod *= i; prod }
  end

  # discrete math xPn for x == self.length
  # don't do this for really big arrays...
  # also, these are order-conscious
  def permutations_for n
    return [] unless n > 0
    return self if n == 1
    n == self.length if n > self.length

    self.inject([]) { |perm,i| perm + _perm(n-1,[i], self-[i]) }
  end

  def _perm(n, start, rem)
    return rem.inject([]) { |perm,i| perm << (start+[i]) && perm } if n == 1
    return rem.inject([]) { |perm,i| perm + _perm(n-1,(start+[i]),rem-[i]) }
  end

  # discrete math xCn for x == self.length
  # assumes that the array is sorted
  # not conscious of order in results
  def combinations_for n
    return [] if n > self.length || self.length == 0 || n == 0
    return [self] if n == self.length
    return self.inject([]) { |sum,i| sum << [i] } if n == 1

    combos = []
    0.upto((self.length-(n-1))-1) do |idx|
      self[idx+1..-1].combinations_for(n-1).each do |arr|
        combos << (arr << self[idx])
      end
    end

    combos
  end

  def collapse
    out = []
    self.each do |v|
      v = [v] unless v.class == Array
      out += v
    end

    out
  end
end

class Hash
  def value_ct val
    ct = 0
    self.each { |k,v| ct += 1 if v == val }
    ct
  end

  def sum
    self.values.sum
  end

  def product
    self.values.product
  end

  def addkeys(arr, default = nil)
    arr.each { |v| self[v] = default }
  end
end

class MathUtils
  def self.coprime?(i1,i2)
    f1 = i1.to_i.factors
    f2 = i2.to_i.factors
    (f1 & f2).length > 0
  end

  def self.combination(n, r)
    n.factorial/(r.factorial*(n-r).factorial)
  end

  def self.triangle n
    n*(n+1)/2
  end

  def self.square n
    n**2
  end

  def self.pentagon n
    n*(3*n-1)/2
  end

  def self.hexagon n
    n*(2*n-1)
  end

  def self.heptagon n
    n*(5*n-3)/2
  end

  def self.octagon n
    n*(3*n-2)
  end

  def self.gcd(a,b)
    a%b==0? b : gcd(b,a%b)
  end
end

class Sieve
  def self.get_primes_to max
    series = (2..max).to_a
    sqrt  = max**0.5

    0.upto series.length do |k|
      next unless series[k]

      candidate = series[k]
      wipe = (candidate**2)-2 # abuse indices. arr[n] = n+2
      while wipe <= max
        series[wipe] = nil
        wipe += candidate
      end
    end

    series.compact
  end

  def self.phi_to(max, primes = nil)
    primes = self.get_primes_to(max/2) unless primes
    ret = { 1 => 1 }

    2.upto max do |i|
      next if ret.include? i
      p i if 0 == i % 1000

      # phi of a prime i is i-1
      if i.prime?
        ret[i] = i-1

      # general case, take prime factors
      else
        pf = i.prime_factors(primes)
        ret[i] = pf.inject(1) do |prod, pair|
          prod *= (pair[0]-1)*pair[0]**(pair[1]-1)
        end
      end

      # power of prime, p**a - p**(a-1)
      pow = 2
      ipow = i**pow
      while ipow < max
        ret[ipow] = ipow*(1-(1/i))
        pow += 1
        ipow = i**pow
      end
    end

    ret
  end

  def self.clever_phi_to max
    phi = { 0 => 0, 1 => 1 }
    nonce = { 0 => nil, 1 => nil }

    2.upto max do |i|
      next if nonce.include? i

      phi[i] = i-1
      2.upto(max/i) do |j|
        ij = i*j
        nonce[ij] = nil

        phi[ij] ||= ij
        phi[ij] = phi[ij]/i*(i-1)
      end
    end

    phi
  end

  def self.quick_phi_to_1m
    self.philist("phi_to_1m.txt")
  end

  def self.quick_phi_to_10m
    self.philist("phi_to_10m.txt")
  end

  def self.quick_primes_to_1m(ashash = false)
    self.primelist("primes_to_1m.txt", ashash)
  end

  def self.quick_primes_to_15m(ashash = false)
    self.primelist("primes_to_15m.txt", ashash)
  end

  def self.quick_primes_to_100m(ashash = false)
    self.primelist("primes_to_100m.txt", ashash)
  end

  def self.quick_primes_to max
    raise 'Can\'t go above 100M' unless max <= 100_000_000
    primes = []
    File.open("primes_to_100m.txt") do |file|
      while line = file.gets
        line.chomp.split.each do |s|
          i = s.to_i
          break if i > max
          primes << i
        end
      end
    end
    primes
  end

  protected
  def self.primelist(file, hash)
    return self.primelisthash(file) if hash
    primes = []
    File.open(file) do |file|
      while line = file.gets
        line.chomp.split.each do |s|
          primes << s.to_i
        end
      end
    end
    primes
  end

  def self.primelisthash(file)
    primes = {}
    File.open(file) do |file|
      while line = file.gets
        line.chomp.split.each do |s|
          primes[s.to_i] = nil
        end
      end
    end
    primes
  end

  def self.philist(file)
    phi = {}
    File.open(file) do |file|
      while line = file.gets
        n, pn = line.chomp.split(':')
        phi[n.to_i] = pn.to_i
      end
    end
    phi
  end
end

class Permuter
  attr_accessor :seq, :len

  def initialize seq
    @seq = seq
    @len = seq.length
  end

  def permute!
    @len.downto 0 do |i|
      chunk = @seq[i..-1]
      next if chunk.rsorted?

      nint = chunk.select { |k| k > chunk[0] }.min
      @seq.swap! chunk[0], nint
      @seq[(i+1)..-1] = @seq[(i+1)..-1].reverse
      return self
    end

    raise 'The set is already permuted to its maximum state'
  end

  def to_s
    @seq.join ""
  end

  def to_i
    self.to_s.to_i
  end
end

class Rational
  def reciprocal
    return 0 unless self.nonzero?
    self.denominator/self.numerator
  end

  def fractional_part
    self.remainder(1)
  end

  def whole_part
    self.floor
  end
end

class Dice

  def self.roll(n,d)
    (1..n).inject(0) { |s,i| s + (rand*d).ceil }
  end

  @probs = {}
  def self.probability(tgt,n,d)
    memo_s = "#{tgt}:#{n}:#{d}"
    return @probs[memo_s] if @probs.include? memo_s
    return 0 if tgt <= 0
    return 0 if n*d < tgt
    return 1/d if n == 1

    sum = 0
    1.upto [d,tgt-1].min do |r|
      # r is the current roll of this die, which
      # is always 1/d
      dp = (1/d * self.probability(tgt-r,n-1,d))
      sum += dp
    end

    (@probs[memo_s] = sum)
  end

end
