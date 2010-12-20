require 'mathn'

frac = nil
max = 3/7
lmax = 2/5
lim = 1000000

lim.downto 10 do |d|
  st = (d*lmax).floor
  1.upto d-1 do |n|
    f = n/d

    next if f < lmax
    break if f >= max
    frac = "#{n}/#{d}"
    lmax = f
    p frac
  end
end

p frac
