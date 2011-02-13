lim = 10**8
ed = lim**0.5
squares = (0..ed).inject([]) { |sq,n| sq << n**2 }

@pals = []
1.upto squares.length-1 do |st|
  sum = squares[st]

  (st+1).upto squares.length-1 do |ed|
    sum += squares[ed]
    break if sum > lim
    next unless sum.to_s == sum.to_s.reverse

    @pals << sum
    #puts "#{st}..#{ed} yields #{sum}"
  end
end

# this gave me fits, as I was accidentally adding
# duplicates and couldn't find them.
p @pals.uniq.inject(0) { |sum,p| sum + p }
