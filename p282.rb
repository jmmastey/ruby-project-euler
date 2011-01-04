# need to calculate this over a modulo...
# plus, a stackless version is basically necessary.
# at least with memoization it stack overflows very quickly.

@ack = { "1:1" => 3, "2:2" => 7, "3:3" => 61, }
def ack(m, n)
  key = "#{m}:#{n}"
  puts "#{key} #{@ack.length}"
  return @ack[key] if @ack.include? key
  return (@ack[key] = n + 1) if m == 0
  return (@ack[key] = ack(m-1,1)) if n == 0
  return (@ack[key] = ack(m-1, ack(m, n-1)))
end

1.upto 5 do |n|
  puts ">> #{n}:#{n}: #{ack(n,n)}"
end
