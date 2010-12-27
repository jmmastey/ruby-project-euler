require 'tools'

# runs in 2 min. not bad, but not good either...

@dlookup = {}
def digit_fact n
  unless @dlookup.include? n
    @dlookup[n] = n.to_s.split(//).inject(0) { |sum,s| sum + s.to_i.factorial }
  end

  @dlookup[n]
end

def fact_chain(n, max)
  chain = { n => nil }
  i = 1
  while true
    n = digit_fact n

    return chain.length if chain.include? n
    return 0 if i > max

    chain[n] = nil
    i += 1
  end
end

lim = 1_000_000
target = 60
total = 0
1.upto lim do |n|
  total += 1 if fact_chain(n, target) == target
end

p total
