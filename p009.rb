

def is_pythagorean(a, b, c)
  (a**2 + b**2) == c**2
end

target = 10000
a = b = 0

(target-3).downto 1 do |c|
  ab = target - c
  (ab-1).downto((ab/2)+1) do |b|
    a = ab-b
    puts "#{a},#{b},#{c} is pythagorean (product: #{a*b*c})" if is_pythagorean(a,b,c)
  end
end
