def find_solutions(perimeter)
  solutions = []

  1.upto(perimeter/2) do |c|
    rem = perimeter - c
    csq = c**2

    1.upto(rem/2) do |b|
      a = rem-b
      solutions << [a,b,c] if a**2+b**2 == csq
    end
  end

  solutions
end

lim = 1000
max = 0
maxs = []
1.upto lim do |i|
  s = find_solutions(i)
  if s.length > maxs.length
    max = i
    maxs = s
  end
end

puts "Max was #{max} (#{maxs.length} answers)"
maxs.each { |k| puts k.join "," }
