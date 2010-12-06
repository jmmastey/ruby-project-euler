
tnums = []
pnums = []
hnums = []

ti = 285
pi = 165
hi = 143

start = 1
ct = 100000
start.upto(start+ct) do |i|
  ci = ti+i
  tnums << (ci*(ci+1)/2)

  cp = pi+i
  pnums << (cp*((3*cp)-1)/2)

  hp = hi+i
  hnums << (hp*((2*hp)-1))
end

max = tnums.last
hnums = hnums.select { |k| k <= max }
pnums = pnums.select { |k| k <= max }

hnums.each do |hn|
  next unless pnums.include? hn
  next unless tnums.include? hn

  puts hn
  exit
end

puts "Failed. Sorry. I looked as high as #{tnums.last}"
