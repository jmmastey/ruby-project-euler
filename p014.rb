

def chain_length(seed, chaincache)
  len = 0
  val = seed
  while val != 1
    len += 1

    if val.even?
      val = val/2
    else
      val = 3*val + 1
    end

    if chaincache.include? val
      return len + chaincache[val]
    end
  end

  len
end

maxlen = maxseed = 0
chaincache = {}

2.upto 1_000_000 do |seed|
  len = chain_length(seed, chaincache)
  chaincache[seed] = len
  maxlen = [maxlen,len].max
  maxseed = seed if len == maxlen

  #puts "#{seed} (#{maxlen})" if 0 == seed % 10000
end

puts maxseed
