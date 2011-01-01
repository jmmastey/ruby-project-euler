require 'mathn'

st = 1_000_000_000_000

num = st
while true
  qtr = num / 4.0

  puts "trying #{num}" if 0 == num % 1_000

  # we need to over/under the .75 number
  if qtr % 1 == 0
    num += 1
    next
  end

  threeq = (qtr*3).to_i
  over = threeq/num
  under = (threeq-1)/(num-1)

  if over*under != 1/2
    num += 1
    next
  end

  p num
  p threeq
  exit
end
