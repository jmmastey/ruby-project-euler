squares = { 1 => nil }
sqlist = [1]
base = 1
while true
  base += 1
  square = base**2
  squares[square] = nil
  sqlist << square

  2.upto(square/2) do |y|
    x = square-y
    next unless x > y
    next unless squares.include?(x-y)

    sqlist.each do |subsq|
      break if subsq >= y
      z = y - subsq

      #next unless (x+y).square? #implicit
      #next unless (y-z).square? #implicit

      next unless squares.include?(x+z)
      next unless squares.include?(x-z)
      next unless squares.include?(y+z)

      #p [x,y,z,subsq]
      #p [x+y, x-y, y+z, y-z, x+z, x-z]
      #p sqlist
      p x+y+z
      exit
    end
  end
end
