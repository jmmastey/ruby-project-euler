require 'mathn'
require 'tools'

# as opposed to the monte carlo method (which didn't finish within 8 hours),
# this method finishes in about 0.03 seconds, which is acceptably fast :)

# only doing from zero so that I can use array indices down below
sixes = (0..36).inject([]) { |a,n| a << Dice.probability(n,6,6) }
fours = (0..36).inject([]) { |a,n| a << Dice.probability(n,9,4) }


sum = 0
0.upto 36 do |f|
  0.upto(f-1) do |s|
    sum += fours[f]*sixes[s]
  end
end

p sum.to_f
