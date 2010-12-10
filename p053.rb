require 'tools'

# added a caching factorial in utils to speedup by 10x :)

combos = []
23.upto 100 do |n|
  1.upto n do |r|
    next unless MathUtils.combination(n,r) > 1e6
    combos << [n,r]
  end
end

p combos.length
