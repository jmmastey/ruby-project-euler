def origin_in triangle
  return false unless same_side(ORIGIN, triangle[0], triangle[1], triangle[2])
  return false unless same_side(ORIGIN, triangle[1], triangle[0], triangle[2])
  return false unless same_side(ORIGIN, triangle[2], triangle[0], triangle[1])
  return true
end

def same_side(p1, p2, a, b)
  vba = vector(b,a)
  vp1 = vector(p1, a)
  vp2 = vector(p2, a)

  cp1 = cross_product(vba, vp1)
  cp2 = cross_product(vba, vp2)
  dot_product(cp1, cp2) >= 0
end

def vector(a,b)
  [b[0]-a[0], b[1]-a[1], 0]
end

def cross_product(a, b)
  [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]]
end

def dot_product(a,b)
  a[0]*b[0]+a[1]*b[1]+a[2]*b[2]
end

ORIGIN = [0,0]
triangles = []
sum = 0

File.open("p102_triangles.txt") do |file|
  while line = file.gets
    c = line.chomp.split ','
    triangles << [[c[0].to_i, c[1].to_i], [c[2].to_i,c[3].to_i], [c[4].to_i,c[5].to_i]]
  end
end

triangles.each do |triangle|
  sum += 1 if origin_in triangle
end

puts sum
