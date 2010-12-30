require 'mathn'

def pandigital? s
  s.split(//).sort.join('') == "123456789"
end

@fibs = { 0 => 0, 1 => 1, 2 => 1 }
def fib nmult
  return @fibs[nmult] if @fibs.include? nmult

  # Have to hand it to wolfram sometimes...
  # http://mathworld.wolfram.com/FibonacciNumber.html
  if nmult.even?
    n = nmult/2
    f = fib(n+1)**2-fib(n-1)**2
  else
    n = (nmult+1)/2
    m = (nmult-1)/2
    f = fib(n)**2+fib(m)**2
  end

  (@fibs[nmult] = f)
end

a = 1
b = 1
c = 2
while true
  a, b = b, (a+b) % 1_000_000_000_000
  c += 1

  bs = b.to_s

  next unless bs.length >= 12
  next unless pandigital? bs[-9,9]

  bfull = fib(c)
  bfulls = bfull.to_s
  #puts "#{c} has #{bfulls.length} digits"

  next unless pandigital? bfulls[0,9]

  puts c
  exit
end
