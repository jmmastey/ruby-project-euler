require 'tools'

class Chain

  attr_accessor :set, :valid, :start

  def initialize num
    @set = [num]
    @valid = false
    @start = num
  end

  def add num
    @set << num
  end

  def include? num
    @set.include? num
  end

  def length
    @set.length
  end

  def min
    @set.min
  end

  def <=> (other)
    length - other.length
  end

end

lim = 1_000_000
@factors = Sieve.factors_to lim
@factors.keys.each { |k| @factors[k] = @factors[k].sum }
@factors[0] = 0

def factors n
  return @factors[n] if @factors.include? n
end


solved = {}
chains = []

1.upto lim do |i|
  next if solved.include? i

  chain = Chain.new(i)
  target = factors i

  while !chain.include? target
    chain.add target
    target = factors target

    if target == chain.start
      chain.valid = true
      chain.set.each { |i| solved[i] = chain }
      break
    elsif target.nil? or target > lim
      chain.set.each { |i| solved[i] = chain }
      break
    elsif target == 0
      chain.set.each { |i| solved[i] = chain }
      break
    end
  end

  chains << [chain.length, chain] if chain.valid
end

#chains.sort.each { |chain| p chain }
p chains.sort.last[1].min
