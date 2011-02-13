require 'mathn'

def reciprocal_slope n
  case n
    when 0 then nil
    when nil then 0
    else (-1/n)
  end
end

def slope a,b
  return 0 if a[0] == b[0]
  return nil if a[1] == b[1]
  return (b[1]-a[1])/(b[0]-a[0])
end

def is_right(a,b,c)
  # invalid (two colinear points)
  return false if 2 == [a,b,c].count(0)
  return false if 2 == [a,b,c].count(nil)

  # perpendicular slopes
  return true if a == reciprocal_slope(b)
  return true if a == reciprocal_slope(c)
  return true if b == reciprocal_slope(c)

  return false
end

max = 50
coords = []
0.upto max do |x|
  0.upto max do |y|
    coords << [x,y]
  end
end

coords.delete [0,0]

rights = []
c_o = [0,0]
coords.each do |c_p|
  coords.each do |c_q|
    next if c_p == c_q
    next if [c_q,c_p].sort != [c_q,c_p]

    sl_op = slope(c_o, c_p)
    sl_oq = slope(c_o, c_q)
    sl_pq = slope(c_p, c_q)

    next unless is_right(sl_op, sl_oq, sl_pq)
    rights << [c_o,c_p,c_q, sl_op, sl_oq, sl_pq]
  end
end

p rights.length
