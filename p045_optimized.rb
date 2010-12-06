
# dropped triangle numbers as they are a subset of hex numbers

pnums = []
hnums = []

pi = 165
pc = 0
hi = 143
hc = 0

while true
  hi += 1
  hc = (hi*((2*hi)-1))

  while pc < hc
    pi += 1
    pc = (pi*((3*pi)-1)/2)

    if hc == pc
      puts hc
      exit
    end
  end
end
